class_name EarthShield
extends Skill

static var EARTH_SHIELD_BLOCK = 3

func use():
	Globals.main.add_to_queue(BlockCommand.new(EARTH_SHIELD_BLOCK, getOwner()))

func getName():
	return "Earth Shield"

func getDesc():
	return "Gain " + str(EARTH_SHIELD_BLOCK) + " Block."
