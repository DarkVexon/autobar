class_name BigScratch
extends Skill

static var BIG_SCRATCH_DAMAGE = 2

func use():
	Globals.main.add_to_queue(DamageCommand.new(BIG_SCRATCH_DAMAGE, get_target(), getOwner(), DamageCommand.DamageType.PHYSICAL))

func getName():
	return "Big Scratch"

func getDesc():
	return "Deals " + str(BIG_SCRATCH_DAMAGE) + " Physical damage."
