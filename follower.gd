class_name Follower
extends Path2D
@export var follow_line: Line2D
@onready var path_follow_2d = $PathFollow2D

const SPEED_3 = 42.5
const BASE_SPEED = 14.167
@export var speed: float

func _ready():
	curve.clear_points()
	for p in follow_line.points:
		curve.add_point(p)
	
func _process(delta):
	path_follow_2d.progress += delta * BASE_SPEED * 4.85
	#self.global_position = path_follow_2d.global_position
	#self.position.x += 42 * delta

func add_follower(fol):
	if not self.is_node_ready():
		await self.ready
	if not path_follow_2d.is_node_ready():
		await path_follow_2d.ready
		
	path_follow_2d.add_child(fol)
