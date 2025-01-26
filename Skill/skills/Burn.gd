class_name Burn
extends Skill

static var STR_LOSS_PER_FIRE_HIT = 1

func use():
	Globals.main.add_to_queue(LogCommand.new(null, getOwner().combatantName + " skips their turn!"))

func getName():
	return "Burn"

func getDesc():
	return "Passive: Whenever you deal Fire damage, foes hit lose " + str(STR_LOSS_PER_FIRE_HIT) + " Strength."

func onDealDamage(amt, type, target):
	if type == DamageCommand.DamageType.FIRE:
		Globals.main.add_to_queue(StatusCommand.new(-STR_LOSS_PER_FIRE_HIT, target, getOwner(), StatusEffect.StatusType.Strength))
