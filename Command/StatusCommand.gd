class_name StatusCommand
extends Command

var amount : int
var target : Combatant
var source : Combatant
var type : StatusEffect.StatusType

func _init(amt, newTarget, newSource, newType) -> void:
	amount = amt
	target = newTarget
	source = newSource
	type = newType

func execute():
	target.applyStatus(type, amount)
	completed = true
