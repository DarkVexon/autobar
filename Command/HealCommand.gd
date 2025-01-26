class_name HealCommand
extends Command

var amount : int
var target : Combatant

func _init(dmgAmt, newTarget) -> void:
	amount = dmgAmt
	target = newTarget

func execute():
	target.heal(amount)
	Globals.main.logToLog(null, target.combatantName + " healed " + str(amount) + " HP!")
	completed = true
