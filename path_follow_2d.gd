extends PathFollow2D

@export var speed: float = 50

func _process(delta):
	progress += delta * speed
