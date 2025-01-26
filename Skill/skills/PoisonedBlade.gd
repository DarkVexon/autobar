class_name PoisonedBlade
extends Skill

static var POISONED_BLADE_DAMAGE = 2
static var POISONED_BLADE_POISON = 1

func use():
	Globals.main.add_to_queue(DamageCommand.new(POISONED_BLADE_DAMAGE, get_target(), getOwner(), DamageCommand.DamageType.PHYSICAL))
	Globals.main.add_to_queue(StatusCommand.new(POISONED_BLADE_POISON, get_target(), getOwner(), StatusEffect.StatusType.Poison))

func getName():
	return "Poisoned Blade"

func getDesc():
	return "Deal " + str(POISONED_BLADE_DAMAGE) + " Physical damage and apply " + str(POISONED_BLADE_POISON) + " Poison."
