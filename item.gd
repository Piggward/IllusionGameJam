extends Sprite2D
@export var follow_line: Line2D
@onready var path_2d = $"../.."
@onready var path_follow_2d = $".."

const SPEED_3 = 42.5
const BASE_SPEED = 14.167

func _ready():
	for p in follow_line.points:
		path_2d.curve.add_point(p)
	
func _process(delta):
	path_follow_2d.progress += delta * BASE_SPEED * 4
	#self.global_position = path_follow_2d.global_position
	#self.position.x += 42 * delta
