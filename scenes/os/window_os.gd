class_name WindowOS extends Control

var is_resizing: bool = false
var resize_node: Control
var mouse_start: Vector2
var size_start: Vector2
var is_dragging: bool = false

@onready var right: Control = $NinePatchRect/Handles/Right
@onready var bottom: Control = $NinePatchRect/Handles/Bottom
@onready var corner: Control = $NinePatchRect/Handles/Corner
@onready var top_bar: PanelContainer = $NinePatchRect/MarginContainer/Layout/TopBar
@onready var close_button: TextureButton = $NinePatchRect/MarginContainer/Layout/TopBar/HBoxContainer/CloseButton

func _ready() -> void:
	print("size=" + str(size))
	print("position=" + str(position))
	print("global_position=" + str(global_position))
	set_process(false)
	top_bar.gui_input.connect(_on_top_bar_input)
	right.gui_input.connect(_on_right_input)
	bottom.gui_input.connect(_on_bottom_input)
	corner.gui_input.connect(_on_corner_input)
	close_button.pressed.connect(_on_close_button_pressed)
	
func _on_top_bar_input(event: InputEvent) -> void:
	if !(event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT):
		return

	is_dragging = event.pressed
	if (event.pressed):
		_on_drag_started()
	else:
		_on_drag_stopped()

func _on_drag_started() -> void:
	set_process(true)
	mouse_start = global_position - get_global_mouse_position()

func _on_drag_stopped() -> void:
	set_process(false)

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
	if (event.button_index == MOUSE_BUTTON_LEFT):
		if (!is_resizing):
			resize_node = node
			
		is_resizing = event.is_pressed()
		set_process(is_resizing)
		if (is_resizing):
			mouse_start = get_global_mouse_position()
			size_start = size
		
func _process(_delta: float) -> void:
	if (is_resizing):
		var mouse_position: Vector2 = get_global_mouse_position()
		if (resize_node in [bottom, corner]):
			size.y = int(max(40, size_start.y + mouse_position.y - mouse_start.y))
		if (resize_node in [right, corner]):
			size.x = int(max(40, size_start.x + mouse_position.x - mouse_start.x))
	if (is_dragging):
		global_position = get_global_mouse_position() + mouse_start

func _on_close_button_pressed() -> void:
	queue_free()
