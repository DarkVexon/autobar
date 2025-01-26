class_name Bopper
extends Combatant

func setup() -> void:
	maxHp = 5
	hp = 5
	updateHealthInfo()
	combatantName = "Meowkin"
	$NameLabel.text = combatantName
	$SkillBar.maxSkills = 3

func setupSkills():
	addSkill("SmallScratch")
	addSkill("BigScratch")
	addSkill("SmallGuard")
