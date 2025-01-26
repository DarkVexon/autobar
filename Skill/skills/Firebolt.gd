class_name Firebolt
extends Skill

static var FIREBOLT_DAMAGE = 4

func use():
	Globals.main.add_to_queue(DamageCommand.new(FIREBOLT_DAMAGE, get_target(), getOwner(), DamageCommand.DamageType.FIRE))

func getName():
	return "Firebolt"

func getDesc():
	return "Deal 4 Fire damage to an enemy."
