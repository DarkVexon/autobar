class_name SmallGuard
extends Skill

static var SMALL_GUARD_BLOCK = 2

func use():
	Globals.main.add_to_queue(BlockCommand.new(SMALL_GUARD_BLOCK, getOwner()))

func getName():
	return "Small Guard"

func getDesc():
	return "Gain " + str(SMALL_GUARD_BLOCK) + " Block."
