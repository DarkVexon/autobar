class_name SkillBar
extends Control

enum SkillBarState {
	WAITING,
	MOVING
}

@export var maxSkills = 3
var combatantOwner : Combatant
var state = SkillBarState.WAITING
var skills : Array = []
var index : int = 0
var needsMoving = false

func _ready() -> void:
	if get_parent() is Combatant:
		combatantOwner = get_parent()

func _process(delta: float) -> void:
	if state == SkillBarState.MOVING:
		var targetSkill = skills[index]
		if $Pointer.global_position.x < targetSkill.global_position.x:
			$Pointer.global_position.x += 200 * delta
			if $Pointer.global_position.x >= targetSkill.global_position.x:
				state = SkillBarState.WAITING
				targetSkill.activate()
				Globals.main.process_commands()
		elif $Pointer.global_position.x > targetSkill.global_position.x:
			$Pointer.global_position.x -= 500 * delta
			if $Pointer.global_position.x <= targetSkill.global_position.x:
				state = SkillBarState.WAITING
				targetSkill.activate()
				Globals.main.process_commands()
	elif state == SkillBarState.WAITING and Globals.main.curState == Main.GameState.PRE_COMBAT_START:
		for skill in skills:
			if skill.curState == Skill.SkillState.IN_HAND and skill.isPlayerSkill:
				if skill.global_position <= skill.sourceLoc + Vector2(-100, 0) and skill.barIdx > 0:
					var prevSkill = skills[skill.barIdx-1]
					skills[skill.barIdx-1] = skill
					skills[skill.barIdx] = prevSkill
					var oldPos = prevSkill.global_position
					prevSkill.global_position = skill.sourceLoc
					skill.sourceLoc = oldPos
					skill.barIdx -= 1
					prevSkill.barIdx += 1
				elif skill.global_position >= skill.sourceLoc + Vector2(100, 0) and skill.barIdx <= maxSkills:
					var nextSkill = skills[skill.barIdx+1]
					skills[skill.barIdx+1] = skill
					skills[skill.barIdx] = nextSkill
					var oldPos = nextSkill.global_position
					nextSkill.global_position = skill.sourceLoc
					skill.sourceLoc = oldPos
					skill.barIdx += 1
					nextSkill.barIdx -= 1
	elif state == SkillBarState.WAITING and Globals.main.curState == Main.GameState.PICK_POWERUP:
		for skill in skills:
			if skill.curState == Skill.SkillState.IN_HAND and skill.isPlayerSkill:
				if !skill.rewardSkill:
					if skill.global_position <= skill.sourceLoc + Vector2(-100, 0) and skill.barIdx > 0:
						var prevSkill = skills[skill.barIdx-1]
						skills[skill.barIdx-1] = skill
						skills[skill.barIdx] = prevSkill
						var oldPos = prevSkill.global_position
						prevSkill.global_position = skill.sourceLoc
						skill.sourceLoc = oldPos
						skill.barIdx -= 1
						prevSkill.barIdx += 1
					elif skill.global_position >= skill.sourceLoc + Vector2(100, 0) and skill.barIdx < skills.size():
						var nextSkill = skills[skill.barIdx+1]
						skills[skill.barIdx+1] = skill
						skills[skill.barIdx] = nextSkill
						var oldPos = nextSkill.global_position
						nextSkill.global_position = skill.sourceLoc
						skill.sourceLoc = oldPos
						skill.barIdx += 1
						nextSkill.barIdx -= 1

func addSkillByName(skill : String):
	addSkill(Globals.makeSkill(skill))

func addSkill(skill : Skill):
	$SkillsContainer.add_child(skill)
	skills.append(skill)
	skill.parentBar = self
	skill.barIdx = skills.size()-1

func next():
	if needsMoving:
		index += 1
	else:
		needsMoving = true
	if index >= maxSkills:
		index = 0
	state = SkillBarState.MOVING

func instantMoveTicker():
	$Pointer.position = Vector2(-120, 87)
