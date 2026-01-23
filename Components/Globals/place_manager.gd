extends Node

var placing: bool = false
var object: Sushi = null
var level: Node2D
var hover_plate: Plate = null

func _process(delta):
	if Input.is_action_just_pressed("right_click"):
		remove_object()
	if Input.is_action_just_pressed("left_click") and object != null and hover_plate != null:
		hover_plate.add_sushi(object.sushi_type)
	if object != null:
		object.global_position = level.get_global_mouse_position()
		print(object.global_position)
	pass
	
func add_object(s: Sushi):
	if placing:
		object.queue_free()
	s.top_level = true
	object = s
	#object.highlight = true
	level.add_child(object)
	#object.trigger_outline(true)
	object.scale *= 1.6
	placing = true
	
func remove_object():
	if object == null:
		return
	object.queue_free()
	placing = false
