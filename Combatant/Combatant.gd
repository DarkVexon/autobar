class_name Combatant
extends Node

var hp = 13
var maxHp = 13
var block : int = 0
var isDead : bool = false
var combatantName = "Monster"
var statuses = []

func setup():
	pass

func getSkills():
	return getSkillBar().skills

func updateHealthInfo():
	$HealthBar.max_value = maxHp
	$HealthBar.value = hp
	$HealthLabel.text = str(hp) + "/" + str(maxHp)

func _ready() -> void:
	updateHealthInfo()

func setupSkills():
	pass

func addSkill(id):
	var newSkill = Globals.makeSkill(id)
	newSkill.combatantOwner = self
	$SkillBar.addSkill(newSkill)

func getStatusContainer():
	if Globals.main.player == self:
		return Globals.main.get_node("PlayerStatusContainer")
	else:
		return $StatusContainer

func applyStatus(id, amount):
	var newStatus = Globals.makeStatus()
	newStatus.setup(id, amount, self)
	getStatusContainer().add_child(newStatus)
	statuses.append(newStatus)

func calculateDamage(damage, source, type):
	if source != null:
		for status in source.statuses:
			damage = status.modifyDamage(damage)
	for skill in getSkills():
		damage = skill.modifyDamage(damage, type)
		
	return damage

func damage(amount, source : Combatant, type):
	var actualDamageDealt = calculateDamage(amount, source, type)
	var preMin = actualDamageDealt
	if block > 0:
		if block >= actualDamageDealt:
			modBlock(-actualDamageDealt)
		else:
			var toDeal = actualDamageDealt - block
			modBlock(-block)
			hp -= toDeal
	else:
		hp -= actualDamageDealt
	if hp < 0:
		hp = 0
	updateHealthInfo()
	if source == null:
		Globals.main.logToLog(null, combatantName + " took " + str(preMin) + " damage!")
	else:
		for skill : Skill in source.getSkills():
			skill.onDealDamage(preMin, type, self)
		Globals.main.logToLog(null, source.combatantName + " dealt " + str(preMin) + " damage to " + combatantName + "!")
	if hp <= 0:
		die()

func die():
	isDead = true
	$EnemyImg.visible = false
	if Globals.main.get_monsters().is_empty():
		Globals.main.win()

func getSkillBar():
	if Globals.main.player == self:
		return Globals.main.get_node("PlayerSkillBar")
	else:
		return $SkillBar

func modBlock(amt):
	block += amt
	updateBlock()

func updateBlock():
	if !Globals.main.player == self:
		if block > 0:
			$ShieldImg.visible = true
			$BlockAmtLabel.visible = true
			$BlockAmtLabel.text = str(block)
		else:
			$ShieldImg.visible = false
			$BlockAmtLabel.visible = false
	else:
		if block > 0:
			Globals.main.get_node("PlayerBlockImg").visible = true
			Globals.main.get_node("PlayerBlockAmtLabel").visible = true
			Globals.main.get_node("PlayerBlockAmtLabel").text = str(block)
		else:
			Globals.main.get_node("PlayerBlockImg").visible = false
			Globals.main.get_node("PlayerBlockAmtLabel").visible = false

func takeTurn():
	#block = 0
	#updateBlock()
	getSkillBar().next()
	for status in statuses:
		status.startOfTurn()
	for skill in getSkills():
		skill.startOfTurn()

func removeStatus(status):
	getStatusContainer().remove_child(status)
	statuses.erase(status)

func heal(amount):
	hp += amount
	if hp > maxHp:
		hp = maxHp
	updateHealthInfo()

func getDodge():
	var dodge = 0
	for status in statuses:
		dodge += status.modDodge()
	return dodge
