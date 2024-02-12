"""
extends Control

var is_resizing: bool = false
var resize_node: Control

@onready var right: Control = $Right
@onready var bottom: Control = $Bottom
@onready var corner: Control = $Corner

func _ready() -> void:
	right.gui_input.connect(_on_right_input)
	bottom.gui_input.connect(_on_bottom_input)
	corner.gui_input.connect(_on_corner_input)

func _on_right_input(event: InputEvent) -> void:
	if (event is InputEventMouseButton):
		_handle_gui_event(event, right)
	
func _on_bottom_input(event: InputEvent) -> void:
	if (event is InputEventMouseButton):
		_handle_gui_event(event, bottom)
	
func _on_corner_input(event: InputEvent) -> void:
	if (event is InputEventMouseButton):
		_handle_gui_event(event, corner)

func _handle_gui_event(event: InputEventMouseButton, node: Control) -> void:
	if (event.event.button_index == MOUSE_BUTTON_LEFT):
		if (!is_resizing):
			resize_node = node
		is_resizing = event.is_pressed()
		set_process(event.is_pressed())
		
func _process(delta: float) -> void:
	if (is_resizing):
		
"""
