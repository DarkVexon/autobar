class_name HeavyShield
extends Skill

static var STARTING_SHIELD = 6

func use():
	Globals.main.add_to_queue(LogCommand.new(null, getOwner().combatantName + " skips their turn!"))

func getName():
	return "Heavy Shield"

func getDesc():
	return "Passive: Start combats with " + str(STARTING_SHIELD) + " Block."

func startOfCombat():
	Globals.main.logToLog($Icon.texture, getName() + " grants " + str(STARTING_SHIELD) + " Block!")
	Globals.main.player.modBlock(STARTING_SHIELD)
