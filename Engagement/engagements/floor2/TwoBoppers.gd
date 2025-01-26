class_name TwoBoppers
extends Engagement

func getMonsters():
	var monsters = []
	var leftBopper = {}
	leftBopper["id"] = "Bopper"
	leftBopper["position"] = Vector2(200, 200)
	monsters.append(leftBopper)
	var rightBopper = {}
	rightBopper["id"] = "MeowkinArcher"
	rightBopper["position"] = Vector2(1200, 200)
	monsters.append(rightBopper)
	return monsters
