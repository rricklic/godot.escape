class_name HealthBar extends Control

@export var min_value: int = 0
@export var max_value: int = 100
var value: int

@onready var progress_bar: ProgressBar = $HBoxContainer/ProgressBar

func set_value(new_value: int) -> void:
	value = new_value
	progress_bar.value = value

func get_value() -> int:
	return value

func increment_value(amount: int) -> void:
	value += amount
	progress_bar.value = value
