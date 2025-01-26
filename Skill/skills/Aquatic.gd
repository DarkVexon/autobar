class_name Aquatic
extends Skill

static var FIRE_DAMAGE_REDUCTION = 1

func use():
	Globals.main.add_to_queue(LogCommand.new(null, getOwner().combatantName + " skips their turn!"))

func getName():
	return "Aquatic"

func getDesc():
	return "Passive: Takes " + str(FIRE_DAMAGE_REDUCTION) + " less Fire damage from all sources."

func modifyDamage(amt, inType):
	if inType == DamageCommand.DamageType.FIRE:
		return amt-FIRE_DAMAGE_REDUCTION
	return amt
