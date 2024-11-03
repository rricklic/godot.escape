class_name Door extends Node2D

signal signal_door_entered

@onready var action_area: ActionArea = $ActionArea
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	action_area.action_func = _open

func _open(actor: Node2D, action: String) -> void:
	if (actor is PlatformPlayer && actor.has_inventory("key")):
		sprite_2d.frame = 1
		action_area.action_func = _enter_door

func _enter_door(actor: Node2D, action: String) -> void:
	signal_door_entered.emit()
