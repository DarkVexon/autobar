class_name LargeGuard
extends Skill

static var LARGE_GUARD_BLOCK = 4

func use():
	Globals.main.add_to_queue(BlockCommand.new(LARGE_GUARD_BLOCK, getOwner()))

func getName():
	return "Large Guard"

func getDesc():
	return "Gain " + str(LARGE_GUARD_BLOCK) + " Block."
