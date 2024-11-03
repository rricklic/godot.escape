class_name DropItem extends Node2D

@export var item: PackedScene = preload("res://scenes/items/resources/gold.tres")

func _unhandled_input(event: InputEvent) -> void:
	if (event.is_action_pressed("ui_accept")):
		var node: Node = item.instantiate()
		add_child(node)
	
