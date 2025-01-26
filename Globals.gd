class_name Globals
extends Resource

static var main : Main
static var rng : RandomNumberGenerator = RandomNumberGenerator.new()

static var skillScene = preload("res://Skill/Skill.tscn")
static var logEntryScene = preload("res://Log/LogEntry.tscn")
static var rewardItemScene = preload("res://Rewards/RewardItem.tscn")
static var statusScene = preload("res://Status/StatusEffect.tscn")

static func makeMonster(type):
	var newMonster = load("res://Combatant/Enemies/" + type + ".tscn").instantiate()
	newMonster.setup()
	newMonster.setupSkills()
	return newMonster

static func makeSkill(id):
	var newSkill = skillScene.instantiate()
	newSkill.load_type(id)
	return newSkill

static func makeLogEntry(img, text):
	var newLogEntry = logEntryScene.instantiate()
	newLogEntry.loadInfo(img, text)
	return newLogEntry

static func makeRewardItem():
	var newReward = rewardItemScene.instantiate()
	return newReward

static func makeStatus() -> StatusEffect:
	var newStatus = statusScene.instantiate()
	return newStatus
