class_name Main
extends Control

enum GameState {
	PRE_COMBAT_START,
	COMBAT,
	POST_COMBAT,
	PICK_POWERUP,
	DEAD
}

var encounters = {
	1: [OneBopper],
	2: [OneBopper],
	3: [TwoBoppers],
	4: [SingleClawkin],
	5: [SingleRockTroll]
}

func makeEncounterForFloor():
	var toMake = encounters[floor][0].new()
	toMake.create()

func nextFloor():
	if floor == 5:
		curState = GameState.DEAD
	else:
		gameCommands.clear()
		monsters.clear()
		for monster in $MonsterContainer.get_children():
			$MonsterContainer.remove_child(monster)
			monster.queue_free()
		$PlayerSkillBar.index = 0
		$PlayerSkillBar.needsMoving = false
		$PlayerSkillBar.instantMoveTicker()
		for status in $PlayerStatusContainer.get_children():
			$PlayerStatusContainer.remove_child(status)
			status.queue_free()
		player.statuses.clear()
		player.hp = player.maxHp
		player.updateHealthInfo()
		$RewardTopper.global_position.y = -1080
		floor += 1
		curState = GameState.PRE_COMBAT_START
		makeEncounterForFloor()
		combat_index = 0
		for skill in player.getSkills():
			skill.startOfCombat()
		for enemy in get_monsters():
			for skill in enemy.getSkills():
				skill.startOfCombat()

var floor = 1
var curState = GameState.PRE_COMBAT_START
var skillInHand : Skill = null
var gameCommands : Array = []
var curCommand : Command
var player : Combatant = Player.new()
var monsters : Array = []
var combat_index = 0 # 0 = player, 1-X = monsters

var num_slots = 5

func setupPlayerSkills():
	$PlayerSkillBar.addSkillByName("BasicStrike")
	$PlayerSkillBar.addSkillByName("DoNothing")
	$PlayerSkillBar.addSkillByName("BasicStrike")
	$PlayerSkillBar.addSkillByName("DoNothing")
	$PlayerSkillBar.addSkillByName("BasicStrike")
	$PlayerSkillBar.addSkillByName("DoNothing")
	for skill in $PlayerSkillBar.skills:
		skill.isPlayerSkill = true

func _ready() -> void:
	Globals.main = self
	$PlayerSkillBar.combatantOwner = player
	setupPlayerSkills()
	OneBopper.new().create()

var validSkills = [
	"Assassinate",
	"Firebolt",
	"Empower",
	"Firebolt",
	"Firestorm",
	"MirrorImageSkill",
	"PoisonedBlade",
	"QuickSlash",
	"SummonBlade",
	"HeavyShield",
	"LargeGuard"
]

func getRandomSkill():
	return validSkills.pick_random()

func _process(delta: float) -> void:
	match (curState):
		GameState.PRE_COMBAT_START:
			pass
		GameState.COMBAT:
			pass
		GameState.POST_COMBAT:
			if $RewardTopper.global_position.y < 0:
				$RewardTopper.global_position.y += 700 * delta
				if $RewardTopper.global_position.y >= 0:
					$RewardTopper.global_position.y = 0
					curState = GameState.PICK_POWERUP
			pass
		GameState.PICK_POWERUP:
			pass
		GameState.DEAD:
			if $DeathTopper.modulate.a < 0.8:
				$DeathTopper.modulate.a += delta * 5

func add_monster(newMonster, position):
	$MonsterContainer.add_child(newMonster)
	monsters.append(newMonster)
	newMonster.global_position = position

func runNextBar():
	var barToRun
	if combat_index == 0:
		barToRun = player
	else:
		barToRun = get_monsters()[combat_index-1]
	barToRun.takeTurn()

func process_commands():
	if curState == GameState.COMBAT:
		if curCommand == null or curCommand.completed: # no running command
			if gameCommands.is_empty(): # no queued commands
				runNextBar() # get the next bar to move and move it
				combat_index += 1
				if combat_index > get_monsters().size(): #limit to num monsters plus one for player:
					combat_index = 0
			else: #queued commands
				curCommand = gameCommands.pop_front()
				curCommand.execute()
				if curCommand.completed:
					process_commands()

func get_monsters():
	var valids = []
	for monster in monsters:
		if !monster.isDead:
			valids.append(monster)
	return valids

func get_leftmost_enemy():
	return get_monsters()[0]

func add_to_queue(command : Command):
	gameCommands.append(command)

func startCombat():
	curState = GameState.COMBAT
	process_commands()

func win():
	if floor == 5:
		curState = GameState.DEAD
	else:
		curState = GameState.POST_COMBAT
		for child in $RewardTopper/RewardContainer.get_children():
			$RewardTopper/RewardContainer.remove_child(child)
			child.queue_free()
		for i in 3:
			var newRewardItem = Globals.makeRewardItem()
			$RewardTopper/RewardContainer.add_child(newRewardItem)
			newRewardItem.setup(getRandomSkill())

func _on_start_combat_button_pressed() -> void:
	if curState == GameState.PRE_COMBAT_START:
		startCombat()

func displayTooltip(newName, desc, inPos):
	$Tooltip.setup(newName, desc, inPos)

func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(load("res://MainMenu/MainMenu.tscn"))

func logToLog(sourceImg, sourceText):
	var newLogEntry = Globals.makeLogEntry(sourceImg, sourceText)
	$ScrollContainer/LogContainer.add_child(newLogEntry)
	$ScrollContainer.itemAdded = true

func getRandomEnemy():
	return get_monsters().pick_random()
