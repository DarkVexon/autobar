class_name SingleRockTroll
extends Engagement

func getMonsters():
	var monsters = []
	var leftBopper = {}
	leftBopper["id"] = "RockTroll"
	leftBopper["position"] = Vector2(575, 150)
	monsters.append(leftBopper)
	return monsters
