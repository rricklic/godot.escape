class_name PlatformLevel extends Node2D

@onready var door: Door = $Door
@onready var label: Label = $Label

func _ready() -> void:
	door.signal_door_entered.connect(_show_win)

func _show_win() -> void:
	label.visible = true
