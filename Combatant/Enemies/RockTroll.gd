class_name RockTroll
extends Combatant

func setup() -> void:
	maxHp = 11
	hp = 11
	updateHealthInfo()
	combatantName = "Rock Troll"
	$NameLabel.text = combatantName
	$SkillBar.maxSkills = 4

func setupSkills():
	addSkill("Club")
	addSkill("TrollHide")
	addSkill("ClubSmash")
	addSkill("EarthShield")
