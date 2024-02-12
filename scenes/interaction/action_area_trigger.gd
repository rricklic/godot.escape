class_name ActionAreaTrigger extends Area2D

# TODO: perform different actions on a single ActionArea

################################################################################
# Description: An area which keeps registers of ActionArea instances
# that have entered and deregisters those that exited. If more than one
# ActionArea is registered control which has focus. When action perform button
# is pressed, call ActionArea.perform_action callback
################################################################################

@export var actor: Node2D

var last_index: int = 0
var index: int = 0
var areas: Array[ActionArea] = []

func _ready() -> void:
	area_entered.connect(_register)
	area_exited.connect(_deregister)

func _register(area: Area2D) -> void:
	if (area is ActionArea):
		print("register " + str(area.get_instance_id()))
		areas.push_back(area)
		if (areas.size() == 1):
			_select_area()
	
func _deregister(area: Area2D) -> void:
	if (area is ActionArea):
		area.on_exited(actor)
		print("deregister " + str(area.get_instance_id()))
		areas.erase(area)
		index = 0 if areas.is_empty() else min(index, areas.size() - 1)
		_select_area()
	
func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("perform_action")):
		_perform_action()

	if (event.is_action_pressed("prev_action")):
		_next_action(-1)
	elif (event.is_action_pressed("next_action")):
		_next_action(1)

func _perform_action() -> void:
	if (areas.is_empty()):
		return
	
	areas[index].perform_action(actor, "") # TODO: support different actions
	
func _next_action(increment: int) -> void:
	if (areas.is_empty()):
		return

	last_index = index
	index = posmod(index + increment, areas.size())
	if (index != last_index):
		_select_area()
	
func _select_area() -> void:
	if (areas.is_empty()):
		return

	areas[index].on_entered(actor)
	if (index != last_index && last_index < areas.size()):
		areas[last_index].on_exited(actor)
