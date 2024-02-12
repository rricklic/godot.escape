class_name Infection extends Node2D

@onready var label: Label = $Label
@onready var sprite_2d: Sprite2D = $Sprite2D

var total_time: float = 0.0

func _process(delta: float) -> void:
	total_time += delta
	var sin_result: float = sin(total_time * 4)
	label.material.set_shader_parameter("flash_amount", (sin_result + 1) / 2.0)
	sprite_2d.material.set_shader_parameter("flash_amount", (sin_result + 1) / 4.0)
	#label.scale = Vector2(sin_result + 0.5, sin_result + 0.5)
