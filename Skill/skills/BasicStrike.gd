class_name BasicStrike
extends Skill

static var BASIC_STRIKE_DAMAGE = 3

func use():
	Globals.main.add_to_queue(DamageCommand.new(BASIC_STRIKE_DAMAGE, get_target(), getOwner(), DamageCommand.DamageType.PHYSICAL))

func getName():
	return "Slash"

func getDesc():
	return "Deal " + str(BASIC_STRIKE_DAMAGE) + " Physical damage to an enemy."
