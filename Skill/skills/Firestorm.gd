class_name Firestorm
extends Skill

static var FIRESTORM_DAMAGE = 3

func use():
	for enemy in Globals.main.get_monsters():
		Globals.main.add_to_queue(DamageCommand.new(FIRESTORM_DAMAGE, enemy, getOwner(), DamageCommand.DamageType.FIRE))

func getName():
	return "Firestorm"

func getDesc():
	return "Deal 3 Fire damage to all enemies."
