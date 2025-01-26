class_name BlockCommand
extends Command

var amount : int
var target : Combatant

func _init(dmgAmt, newTarget) -> void:
	amount = dmgAmt
	target = newTarget

func execute():
	target.modBlock(amount)
	Globals.main.logToLog(null, target.combatantName + " gained " + str(amount) + " Block!")
	completed = true
