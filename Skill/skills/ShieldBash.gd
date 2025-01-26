class_name ShieldBash
extends Skill

static var SHIELD_BASH_DAMAGE = 3
static var SHIELD_BASH_BLOCK = 3

func use():
	Globals.main.add_to_queue(DamageCommand.new(SHIELD_BASH_DAMAGE, get_target(), getOwner(), DamageCommand.DamageType.PHYSICAL))
	Globals.main.add_to_queue(BlockCommand.new(SHIELD_BASH_BLOCK, getOwner()))

func getName():
	return "Shield Bash"

func getDesc():
	return "Deal " + str(SHIELD_BASH_DAMAGE) + " Physical damage and gain " + str(SHIELD_BASH_BLOCK) + " Block."
