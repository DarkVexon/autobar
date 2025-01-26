class_name SummonBlade
extends Skill

static var FLYING_SWORD_AMOUNT : int = 2

func use():
	Globals.main.add_to_queue(StatusCommand.new(FLYING_SWORD_AMOUNT, getOwner(), getOwner(), StatusEffect.StatusType.FlyingSword))

func getName():
	return "Summon Blade"

func getDesc():
	return "At the start of each of your turns, deal " + str(FLYING_SWORD_AMOUNT) + " Physical damage to a random enemy."
