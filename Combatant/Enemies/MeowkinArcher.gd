class_name MeowkinArcher
extends Combatant

func setup() -> void:
	maxHp = 4
	hp = 4
	updateHealthInfo()
	combatantName = "Meowkin Archer"
	$NameLabel.text = combatantName
	$SkillBar.maxSkills = 3

func setupSkills():
	addSkill("BigScratch")
	addSkill("MirrorImageSkill")
	addSkill("BigScratch")
