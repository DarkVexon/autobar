class_name DamageCommand
extends Command

enum DamageType {
	PHYSICAL,
	FIRE,
	HP_LOSS
}

var amount : int
var target : Combatant
var source : Combatant
var type : DamageType

func _init(dmgAmt, newTarget, newSource, newType) -> void:
	amount = dmgAmt
	target = newTarget
	source = newSource
	type = newType

func calculateHit():
	var hitRate : int
	if type == DamageType.HP_LOSS or source == null:
		return true
	if type == DamageType.PHYSICAL:
		hitRate = 85
	else:
		hitRate = 100
	hitRate -= target.getDodge()
	return Globals.rng.randi_range(0, 100) <= hitRate

func execute():
	if calculateHit():
		target.damage(amount, source, type)
	else:
		var name = "???"
		if source != null:
			name = source.combatantName
		Globals.main.logToLog(null, name + " missed!")
	completed = true
