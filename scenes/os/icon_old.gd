class_name IconOld extends Node2D

var mouse_offset: Vector2
var is_pressed: bool = false

@onready var button: Button = $Button

func _ready() -> void:
	button.button_down.connect(_on_pressed)
	button.button_up.connect(_on_released)

# Called as fast as possible, so delta is not constant
func _process(delta: float) -> void:
	if (is_pressed):
		global_position = get_global_mouse_position() + mouse_offset

# Called in sync with frame rate (1/60th second), so delta should be constant
func _physics_process(delta: float) -> void:
	pass
	
func _on_pressed() -> void:
	mouse_offset = global_position - get_global_mouse_position() 
	is_pressed = true
	
func _on_released() -> void:
	is_pressed = false
