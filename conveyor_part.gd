class_name Belt
extends Sprite2D

@export var conveyor: Line2D
@export var next_conveyor: Belt
@export var conveyor_type: ConveyorType

enum ConveyorType { EAST, WEST, SOUTH }

var plates_in_inner_area: Array[Plate] = []
var plate_queue: Array[Plate] = []
var time_since_last_plate := 0.0
var current_plates_on_belt = 0

const CONVEYOR_FOLLOWER = preload("uid://pgpgaakk3b8f")
const PLATE = preload("uid://sg5fl8y6cfuh")
const INITIAL_PLATES_ON_BELT = 2
const BELT_SPEED = 0.1
const INITIAL_QUEUE = 2

@onready var inner_area = $InnerArea

@onready var queue = $Queue
@onready var path_2d = $Path2D

func _ready():
	set_initial_plates()
	inner_area.area_entered.connect(_on_inner_area_area_entered)
	inner_area.area_exited.connect(_on_inner_area_area_exited)
	var mat := conveyor.material as ShaderMaterial
	mat.set_shader_parameter("speed", Vector2(-3, 0))
	path_2d.curve.clear_points()
	for p in conveyor.points:
		path_2d.curve.add_point(p)
	
func _process(delta):
	time_since_last_plate += delta
	if (time_since_last_plate * BELT_SPEED) >= 1.0 / current_plates_on_belt:
		spawn_from_queue()
		time_since_last_plate = 0.0
	
func spawn_from_queue():
	var plate = plate_queue.pop_front()
	spawn_follow(0.0, plate)
	
func set_initial_plates():
	for i in INITIAL_PLATES_ON_BELT:
		var position = i * (1.0 / float(INITIAL_PLATES_ON_BELT))
		spawn_follow(position)
	current_plates_on_belt = INITIAL_PLATES_ON_BELT
	
	for i in INITIAL_QUEUE:
		var plate = PLATE.instantiate()
		plate_queue.append(plate)
		queue.add_child(plate)
	
func spawn_follow(ratio: float = 0.0, plate: Plate = null):
	var follower: PathFollow2D = CONVEYOR_FOLLOWER.instantiate()
	follower.start_ratio = ratio
	follower.speed = BELT_SPEED
	path_2d.add_child(follower)
	if not follower.is_node_ready():
		await follower.ready
		
	if plate == null:
		plate = PLATE.instantiate()
		follower.add_child(plate)
	else:	
		plate.reparent(follower)
	plate.position = Vector2.ZERO
	plate.rotation = 0
	follower.reached_end.connect(_on_plate_finish)
	
func add_to_queue(plate: Plate):
	plate.reparent(queue)
	plate_queue.append(plate)

func _on_plate_finish(follow: PathFollow2D):
	follow.disconnect("reached_end", _on_plate_finish)
	var plate = follow.get_child(0)
	next_conveyor.add_to_queue(plate)
	follow.queue_free()

func _on_inner_area_area_entered(area):
	var parent = area.get_parent()
	if parent is Plate:
		plates_in_inner_area.append(parent)
		parent.set_available(true)
	pass # Replace with function body.


func _on_inner_area_area_exited(area):
	var parent = area.get_parent()
	if parent is Plate:
		plates_in_inner_area.erase(parent)
		parent.set_available(false)
	pass # Replace with function body.
