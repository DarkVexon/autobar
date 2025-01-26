class_name QuickSlash
extends Skill

static var QUICK_SLASH_DAMAGE = 2

func use():
	Globals.main.add_to_queue(DamageCommand.new(QUICK_SLASH_DAMAGE, get_target(), getOwner(), DamageCommand.DamageType.PHYSICAL))
	Globals.main.combat_index -= 1

func getName():
	return "Quick Slash"

func getDesc():
	return "Quick. Deal " + str(QUICK_SLASH_DAMAGE) + " Physical damage."
