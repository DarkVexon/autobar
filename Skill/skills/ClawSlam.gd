class_name ClawSlam
extends Skill

static var CLAW_SLAM_DAMAGE = 6

func use():
	Globals.main.add_to_queue(DamageCommand.new(CLAW_SLAM_DAMAGE, get_target(), getOwner(), DamageCommand.DamageType.PHYSICAL))

func getName():
	return "Claw Slam"

func getDesc():
	return "Deal " + str(CLAW_SLAM_DAMAGE) + " Physical damage to an enemy."
