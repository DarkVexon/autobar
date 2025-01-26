class_name Club
extends Skill

static var CLUB_DAMAGE = 3

func use():
	Globals.main.add_to_queue(DamageCommand.new(CLUB_DAMAGE, get_target(), getOwner(), DamageCommand.DamageType.PHYSICAL))

func getName():
	return "Club Bash"

func getDesc():
	return "Deal " + str(CLUB_DAMAGE) + " Physical damage to an enemy."
