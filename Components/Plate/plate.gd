class_name Plate
extends Node2D

var content: Array[Sushi] = []
var can_add: bool = false
var available: bool = false
const SUSHI = preload("uid://bs4ddgyko43ea")

const MAX_SIZE = 4

@onready var food_layouts = $FoodLayouts
@onready var available_panel = $AvailablePanel
@onready var gpu_particles_2d = $GPUParticles2D

func _ready():
	set_available(false)

func set_available(b: bool):
	available_panel.visible = b
	gpu_particles_2d.visible = b
	gpu_particles_2d.emitting = b
	can_add = b

func can_add_sushi():
	return (content.size() < MAX_SIZE) and can_add

func add_sushi(type: Sushi.SushiType):
	if not can_add_sushi():
		return
	var next_layout = content.size()
	var layout = food_layouts.get_child(next_layout)
	var sushi: Sushi = SUSHI.instantiate()
	sushi.sushi_type = type
	#layout.add_child(sushi)
	content.append(sushi)
	plate_sorting(layout, content)
		
		
func plate_sorting(layout: Node2D, sushis: Array[Sushi]):
	var pos = layout.get_children()
	for c in pos.size():
		if sushis[c].is_node_ready():
			sushis[c].reparent(pos[c])
			sushis[c].position = Vector2.ZERO
		else:
			pos[c].add_child(sushis[c])


func _on_available_panel_mouse_entered():
	PlaceManager.hover_plate = self
	pass # Replace with function body.


func _on_available_panel_mouse_exited():
	if PlaceManager.hover_plate == self:
		PlaceManager.hover_plate = null
	pass # Replace with function body.
