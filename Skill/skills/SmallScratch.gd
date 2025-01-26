class_name SmallScratch
extends Skill

static var SMALL_SCRATCH_DAMAGE = 1

func use():
	Globals.main.add_to_queue(DamageCommand.new(SMALL_SCRATCH_DAMAGE, get_target(), getOwner(), DamageCommand.DamageType.PHYSICAL))

func getName():
	return "Small Scratch"

func getDesc():
	return "Deals " + str(SMALL_SCRATCH_DAMAGE) + " Physical damage."
