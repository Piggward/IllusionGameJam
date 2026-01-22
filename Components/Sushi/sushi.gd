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
@onready var sushi_sprite = $SushiSprite

const NIGIRI_YELLOW_SCENE = preload("uid://dxh10j1lgmq1j")
const NIGIRI_RED_SCENE = preload("uid://dko7cup46twmo")
const ONIGIRI_SCENE = preload("uid://dffuh0rjnxay0")
const ROLL_GREEN_SCENE = preload("uid://c24nqjtivjydl")
const ROLL_WHITE_SCENE = preload("uid://d26icmhq5oy3c")
const WASABI_SCENE = preload("uid://cdheubrfunaaa")

func _ready():
	sushi_sprite.texture = get_sushi_text()

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
