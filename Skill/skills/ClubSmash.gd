class_name ClubSmash
extends Skill

static var CLUB_SMASH_DAMAGE = 7

func use():
	Globals.main.add_to_queue(DamageCommand.new(CLUB_SMASH_DAMAGE, get_target(), getOwner(), DamageCommand.DamageType.PHYSICAL))

func getName():
	return "Club Smash!"

func getDesc():
	return "Deal " + str(CLUB_SMASH_DAMAGE) + " Physical damage to an enemy."
