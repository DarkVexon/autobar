extends Control

var setupThisFrame = false
var setupLastFrame = false

func _process(delta: float) -> void:
	if setupThisFrame:
		setupThisFrame = false
		setupLastFrame = true
	elif setupLastFrame:
		setupLastFrame = false
	else:
		visible = false

func setup(inName, desc, position : Vector2):
	visible = true
	global_position = position
	if global_position.x > get_viewport_rect().size.x - size.x:
		global_position.x = get_viewport_rect().size.x - size.x
	if global_position.y > get_viewport_rect().size.y - size.y:
		global_position.y = get_viewport_rect().size.y - size.y
	setupThisFrame = true
	$NameLabel.text = inName
	$DescLabel.text = desc
