class_name Empower
extends Skill

static var EMPOWER_STR = 2

func use():
	Globals.main.add_to_queue(StatusCommand.new(EMPOWER_STR, getOwner(), getOwner(), StatusEffect.StatusType.Strength))

func getName():
	return "Empower"

func getDesc():
	return "Deal " + str(EMPOWER_STR) + " more Physical damage from all sources for the rest of combat."
