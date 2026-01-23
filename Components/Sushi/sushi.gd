class_name Sushi
extends Node2D

enum SushiType {
	NIGIRI_YELLOW,
	ONIGIRI,
	ROLL_GREEN,
	NIGIRI_RED,
	ROLL_WHITE,
	WASABI
}

@export var sushi_type: SushiType
@export var highlight: bool = false
@onready var sushi_sprite = $SushiSprite

const NIGIRI_YELLOW_SCENE = preload("uid://dxh10j1lgmq1j")
const NIGIRI_RED_SCENE = preload("uid://dko7cup46twmo")
const ONIGIRI_SCENE = preload("uid://dffuh0rjnxay0")
const ROLL_GREEN_SCENE = preload("uid://c24nqjtivjydl")
const ROLL_WHITE_SCENE = preload("uid://d26icmhq5oy3c")
const WASABI_SCENE = preload("uid://cdheubrfunaaa")
const PLACING_COLOR = Color("8dd1ba")
const IDLE_COLOR = Color("000000")

func _ready():
	sushi_sprite.texture = get_sushi_text()
	var mat := sushi_sprite.material as ShaderMaterial
	#var color = IDLE_COLOR if not highlight else PLACING_COLOR
	var color = IDLE_COLOR if not highlight else PLACING_COLOR
	mat.set_shader_parameter("outline_color", color)
	
func trigger_outline(value: bool):
	pass
	#var v = 1.4 if value else 0.0
	#var mat := sushi_sprite.material as ShaderMaterial
	#mat.set_shader_parameter("outline_thickness", v)
	#pass

func get_sushi_text(type: SushiType = sushi_type) -> Texture:
	match type:
		SushiType.NIGIRI_YELLOW:
			return NIGIRI_YELLOW_SCENE
		SushiType.NIGIRI_RED:
			return NIGIRI_RED_SCENE
		SushiType.ONIGIRI:
			return ONIGIRI_SCENE
		SushiType.ROLL_GREEN:
			return ROLL_GREEN_SCENE
		SushiType.ROLL_WHITE:
			return ROLL_WHITE_SCENE
		SushiType.WASABI:
			return WASABI_SCENE
		_:
			push_error("Unknown SushiType")
			return null
