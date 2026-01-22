class_name Belt
extends Sprite2D

@export var conveyor: Line2D
@export var next_conveyor: Belt
@export var conveyor_type: ConveyorType

enum ConveyorType { EAST, WEST, SOUTH }

var plates_in_inner_area: Array[Plate] = []
var plate_queue: Array[Plate] = []

const FOLLOWER = preload("uid://d2o3i1h73rjtg")
const TEST_ITEM = preload("uid://x3y1ik8cibo5")

func _ready():
	var mat := conveyor.material as ShaderMaterial
	mat.set_shader_parameter("speed", Vector2(-3, 0))
	#mat.set_shader_parameter("tint_color", Color.RED)
	spawn_follow()
	
func spawn_follow():
	var f: Follower = FOLLOWER.instantiate()
	f.follow_line = conveyor
	add_child(f)
	var s = TEST_ITEM.instantiate()
	f.add_follower(s)
	await get_tree().create_timer(1.5).timeout
	spawn_follow()

func _on_inner_area_area_entered(area):
	if area is Plate:
		plates_in_inner_area.append(area)
	pass # Replace with function body.


func _on_inner_area_area_exited(area):
	if area is Plate:
		plates_in_inner_area.erase(area)
		area.set_available(false)
	pass # Replace with function body.
