class_name SushiUI
extends PanelContainer

const UNSELECTED_COLOR: Color = Color("121212a5")
const SELECTED_COLOR: Color = Color("12b233a5")

const SUSHI = preload("uid://bs4ddgyko43ea")
@export var sushi_type: Sushi.SushiType

func _ready():
	self_modulate = UNSELECTED_COLOR

func _on_mouse_entered():
	self_modulate = SELECTED_COLOR
	pass # Replace with function body.

func _on_mouse_exited():
	self_modulate = UNSELECTED_COLOR
	pass # Replace with function body.

func _on_gui_input(event):
	if event.is_action_pressed("left_click"):
		var s: Sushi = SUSHI.instantiate()
		s.sushi_type = self.sushi_type
		PlaceManager.add_object(s)
	pass # Replace with function body.
