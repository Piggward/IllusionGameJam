class_name ConveyorPart
extends Sprite2D
@export var conveyor: Line2D
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
