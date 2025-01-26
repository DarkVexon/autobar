class_name RewardItem
extends Control

func setup(type : String):
	var inSkill : Skill = Globals.makeSkill(type)
	add_child(inSkill)
	inSkill.global_position = global_position + Vector2(350, 200)
	inSkill.isPlayerSkill = true
	inSkill.curState = Skill.SkillState.IN_REWARD
	inSkill.rewardSkill = true
	$NameLabel.text = inSkill.getName()
	$DescLabel.text = inSkill.getDesc()
