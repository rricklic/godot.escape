@tool
class_name ItemPickup extends Node2D

@export var item_data: ItemData_R

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var action_area: ActionArea = $ActionArea

func _ready() -> void:
	sprite_2d.texture = item_data.texture
	action_area.on_entered_func = _on_entered

func _on_entered(actor: Node2D) -> void:
	item_data.on_entered(actor)
	queue_free()
