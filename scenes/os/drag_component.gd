class_name DragComponent extends Node

################################################################################
# Description: 
################################################################################

signal drag_started(event_position)
signal drag_stopped

func handle_mouse_event(event: InputEvent) -> void:
	if !(event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT):
		return
	
	var mouse_event: InputEventMouseButton = event
	if (mouse_event.pressed):
		drag_started.emit(mouse_event.global_position)
	else:
		drag_stopped.emit()
