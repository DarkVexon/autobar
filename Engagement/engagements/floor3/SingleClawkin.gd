class_name SingleClawkin
extends Engagement

func getMonsters():
	var monsters = []
	var leftBopper = {}
	leftBopper["id"] = "Clawkin"
	leftBopper["position"] = Vector2(500, 150)
	monsters.append(leftBopper)
	return monsters
