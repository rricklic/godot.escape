class_name ActionArea extends Area2D

# TODO: perform multiple actions on this area

################################################################################
# Description:
#   An area which reprsents something that can be interacted with.
# Defines callbacks to perform the necessary action. The action is triggered
# by ActionAreaTrigger instances.
#
# Callbacks:
#   action_func - performs action(s) based on input action
#   on_entered_func - performs some action when area entered
#   on_exited_func - performs some action when area exited
#   on_selected_func - 
#   on_deselected_func -
################################################################################

var action_func: Callable = func(actor: Node2D, action: String):
	pass

var on_entered_func: Callable = func(actor: Node2D):
	pass
	
var on_exited_func: Callable = func(actor: Node2D):
	pass

var on_selected_func: Callable = func(actor: Node2D):
	pass

var on_deselected_func: Callable = func(actor: Node2D):
	pass

func perform_action(actor: Node2D, action: String) -> void:
	action_func.call(actor, action)

func on_entered(actor: Node2D) -> void:
	on_entered_func.call(actor)

func on_exited(actor: Node2D) -> void:
	on_exited_func.call(actor)

func on_selected(actor: Node2D) -> void:
	on_selected_func.call(actor)

func on_deselected(actor: Node2D) -> void:
	on_deselected_func.call(actor)
