class_name OneBopper
extends Engagement

func getMonsters():
	var monsters = []
	var leftBopper = {}
	leftBopper["id"] = "Bopper"
	leftBopper["position"] = Vector2(200, 200)
	monsters.append(leftBopper)
	return monsters
