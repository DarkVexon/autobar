class_name Clawkin
extends Combatant

func setup() -> void:
	maxHp = 8
	hp = 8
	updateHealthInfo()
	combatantName = "Clawkin"
	$NameLabel.text = combatantName
	$SkillBar.maxSkills = 3

func setupSkills():
	addSkill("LargeGuard")
	addSkill("ClawSlam")
	addSkill("Aquatic")
