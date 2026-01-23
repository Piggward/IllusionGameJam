extends PathFollow2D

@export var speed: float = 0.1
@export var start_ratio: float = 0.0
var travel_dist: float = 0.0
signal reached_end(follow: PathFollow2D)

func _ready():
	print(start_ratio)
	progress_ratio = start_ratio
	print(progress_ratio)

func _process(delta):
	var speed_ratio = 1.0 if progress_ratio < 0.6 else 0.5
	travel_dist += delta * speed * speed_ratio
	progress_ratio = start_ratio + travel_dist
	if progress_ratio == 1.0:
		reached_end.emit(self)
