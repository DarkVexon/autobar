class_name DoNothing
extends Skill

func use():
	Globals.main.add_to_queue(LogCommand.new(null, getOwner().combatantName + " skips their turn!"))

func getName():
	return "Empty Skill Slot"

func getDesc():
	return "Does nothing."
