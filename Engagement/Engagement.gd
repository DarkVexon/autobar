class_name Engagement
extends Resource

func getMonsters():
	return []

func create():
	var monsters = getMonsters()
	for monster in monsters:
		var newMonster = Globals.makeMonster(monster["id"])
		Globals.main.add_monster(newMonster, monster["position"])
