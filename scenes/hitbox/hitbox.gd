@icon("res://images/node_icons/hitbox_icon.png")
class_name Hitbox extends Area2D

################################################################################
# Description: 
################################################################################

var action: Callable = func(actor: Node2D):
	pass

var stop: Callable = func(actor: Node2D):
	pass

func perform_action(actor: Node2D) -> void:
	action.call(actor)

func stop_action(actor: Node2D) -> void:
	stop.call(actor)
