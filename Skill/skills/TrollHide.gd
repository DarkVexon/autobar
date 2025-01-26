class_name TrollHide
extends Skill

static var HEALING_PER_TURN = 1

func use():
	Globals.main.add_to_queue(LogCommand.new(null, getOwner().combatantName + " skips their turn!"))

func getName():
	return "Troll Hide"

func getDesc():
	return "Passive: " + getOwner().combatantName + " heals " + str(HEALING_PER_TURN) + " HP each turn."

func startOfTurn():
	Globals.main.add_to_queue(HealCommand.new(HEALING_PER_TURN, getOwner()))
