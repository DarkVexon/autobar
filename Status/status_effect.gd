class_name StatusEffect
extends Control

enum StatusType {
	FlyingSword,
	MirrorImage,
	Poison,
	Strength
}

var id : StatusType
var combatantOwner : Combatant
var amount : int

func setup(id, amt, holder):
	load_type(id)
	combatantOwner = holder
	amount = amt
	$NameLabel.text = getName()
	$AmountLabel.text = "x" + str(amount)

func getAmount():
	return amount

func load_type(id):
	self.id = id
	load_img(id)

func load_img(id):
	$Image.texture = load("res://Status/images/" + StatusType.keys()[id] + ".png")

func changeAmount(offset):
	amount += offset
	$AmountLabel.text = "x" + str(amount)

func removeSelf():
	combatantOwner.removeStatus(self)

func startOfTurn():
	match (id):
		StatusType.FlyingSword:
			var foe = Globals.main.getRandomEnemy()
			Globals.main.add_to_queue(LogCommand.new($Image.texture, getName() + " activated!"))
			Globals.main.add_to_queue(DamageCommand.new(getAmount(), foe, combatantOwner, DamageCommand.DamageType.PHYSICAL))
		StatusType.MirrorImage:
			changeAmount(-1)
			if amount <= 0:
				removeSelf()
		StatusType.Poison:
			Globals.main.add_to_queue(LogCommand.new($Image.texture, combatantOwner.combatantName + " is Poisoned!"))
			Globals.main.add_to_queue(DamageCommand.new(getAmount(), combatantOwner, null, DamageCommand.DamageType.HP_LOSS))
	pass

func getName():
	match (id):
		StatusType.FlyingSword:
			return "Flying Sword"
		StatusType.MirrorImage:
			return "Mirror Image"
		StatusType.Poison:
			return "Poison"
		StatusType.Strength:
			return "Strength"
	return "Broken status"

func modDodge():
	match (id):
		StatusType.MirrorImage:
			return 50
	return 0

func modifyDamage(dmg):
	match (id):
		StatusType.Strength:
			return dmg + amount
	return amount
