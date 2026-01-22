class_name Plate
extends Node2D

var content: Array[Sushi] = []
var can_add: bool = false
var available: bool = false

const MAX_SIZE = 4

@onready var food_layouts = $FoodLayouts
@onready var available_panel = $AvailablePanel

func set_available(b: bool):
	available_panel.visible = b

func can_add_sushi(s: Sushi):
	return (content.size() < MAX_SIZE) and can_add

func add_sushi(s: Sushi):
	if not can_add_sushi(s):
		return
	var next_layout = content.size()
	var layout = food_layouts.get_child(next_layout)
	content.append(s)
	plate_sorting(layout, content)
		
		
func plate_sorting(layout: Node2D, sushis: Array[Sushi]):
	var pos = layout.get_children()
	for c in pos.size(): 
		sushis[c].reparent(pos[c])
