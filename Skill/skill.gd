class_name Skill
extends Control

static var propery_names = init_properties()

var combatantOwner : Combatant
var sourceLoc : Vector2
var tarLoc : Vector2
var parentBar : SkillBar
var isPlayerSkill = false
var rewardSkill = false
var barIdx : int
var clickTimer = 0.0
var id : String
@export var overrideId : String = ""

enum SkillState {
	IN_BAR,
	MOVING_TO_POSITION,
	IN_REWARD,
	IN_HAND
}

var curState : SkillState = SkillState.IN_BAR

func _ready() -> void:
	if overrideId != "":
		load_type(overrideId)

func is_hovered():
	var mPos = get_viewport().get_mouse_position()
	if mPos.x >= global_position.x and mPos.x <= global_position.x + 100 and mPos.y >= global_position.y and mPos.y <= global_position.y + 100:
		return true
	return false

func _process(delta: float) -> void:
	if clickTimer > 0:
		clickTimer -= delta
	if is_hovered():
		if Globals.main.skillInHand == null:
			Globals.main.displayTooltip(getName(), getDesc(), get_viewport().get_mouse_position() + Vector2(50, 50))
		if Globals.main.curState != Main.GameState.COMBAT and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and (curState == SkillState.IN_BAR or curState == SkillState.IN_REWARD):
			if isPlayerSkill and Globals.main.skillInHand == null:
				if clickTimer <= 0:
					Globals.main.skillInHand = self
					curState = SkillState.IN_HAND
					sourceLoc = global_position
		if Globals.main.skillInHand != null and Globals.main.skillInHand != self and Globals.main.skillInHand.rewardSkill == true and isPlayerSkill:
			Globals.main.skillInHand.get_parent().remove_child(Globals.main.skillInHand)
			load_type(Globals.main.skillInHand.id)
			clickTimer = 2
			Globals.main.nextFloor()
			Globals.main.skillInHand = null
	if Globals.main.skillInHand == self and curState == SkillState.IN_HAND:
		if !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			Globals.main.skillInHand = null
			curState = SkillState.IN_BAR
			global_position = sourceLoc
		else:
			var mPos = get_viewport().get_mouse_position()
			global_position = mPos + Vector2(-50, -50)

static func init_properties():
	var control_properties := Control.new().get_property_list()
	var box_properties = Skill.new().get_property_list()
	var properties: Array[String] = []
	for i in box_properties:
		var found := false
		for j in control_properties:
			if i.name == j.name:
				found = true
				break
		if found:
			continue
		properties.push_back(i.name)
	return properties

func load_img(id):
	$Icon.texture = load("Skill/skills/imgs/" + id + ".png")

func load_type(id):
	self.id = id
	load_skill_data(id)
	load_img(id)

func load_skill_data(id):
	var properties := {}
	for i in propery_names:
		properties[i] = get(i)
	set_script(load("res://Skill/skills/" + id + ".gd"))
	set_process(true)
	for i in properties:
		set(i, properties[i])

func getOwner():
	if combatantOwner == null:
		return Globals.main.player
	else:
		return combatantOwner

func get_target():
	if combatantOwner == null:
		return Globals.main.get_leftmost_enemy()
	else:
		return Globals.main.player

func getName():
	return "Unknown Skill"

func getDesc():
	return "You shouldn't see this!"

func use():
	pass

func activate():
	Globals.main.add_to_queue(LogCommand.new($Icon.texture, getOwner().combatantName + " used " + getName()))
	use()

func startOfCombat():
	pass

func startOfTurn():
	pass

func modifyDamage(inDamage, inType):
	return inDamage

func onDealDamage(amt, type, target):
	pass
