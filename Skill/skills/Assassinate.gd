class_name Assassinate
extends Skill

static var DAMAGE_PER_SKILL = 2

func use():
	for i in barIdx+1:
		Globals.main.add_to_queue(DamageCommand.new(DAMAGE_PER_SKILL, get_target(), getOwner(), DamageCommand.DamageType.PHYSICAL))

func getName():
	return "Assassinate"

func getDesc():
	return "Deal " + str(DAMAGE_PER_SKILL) + " Physical damage for each skill slot to the left of this."
