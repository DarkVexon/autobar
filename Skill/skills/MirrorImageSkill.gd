class_name MirrorImageSkill
extends Skill

static var MIRROR_IMAGE_TURNS = 3

func use():
	Globals.main.add_to_queue(StatusCommand.new(MIRROR_IMAGE_TURNS, getOwner(), getOwner(), StatusEffect.StatusType.MirrorImage))

func getName():
	return "Mirror Image"

func getDesc():
	return "+50% Dodge chance for 3 turns."
