class_name Player
extends Combatant

func _init() -> void:
	combatantName = "Player"

func updateHealthInfo():
	Globals.main.get_node("PlayerHealthBar").max_value = maxHp
	Globals.main.get_node("PlayerHealthBar").value = hp
	Globals.main.get_node("PlayerHealthBar/PlayerHealthLabel").text = str(hp) + "/" + str(maxHp)

func die():
	print("You died.")
	Globals.main.get_node("DeathTopper").visible = true
	Globals.main.curState = Main.GameState.DEAD
