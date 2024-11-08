class_name HealthBar extends Control

@export var min_value: int = 0
@export var max_value: int = 100
@export var label_text: String

var value: int

@onready var progress_bar: ProgressBar = $HBoxContainer/ProgressBar
@onready var label: Label = $HBoxContainer/Label

func _ready() -> void:
	label.text = label_text

func set_value(new_value: int) -> void:
	value = new_value
	progress_bar.value = value

func get_value() -> int:
	return value

func increment_value(amount: int) -> void:
	value += amount
	progress_bar.value = value
