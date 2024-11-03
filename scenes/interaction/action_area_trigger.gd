class_name ActionAreaTrigger extends Area2D

# TODO: perform different actions on a single ActionArea

################################################################################
# Description: An area which keeps registers of ActionArea instances
# that have entered and deregisters those that exited. If more than one
# ActionArea is registered control which has focus. When action perform button
# is pressed, call ActionArea.perform_action callback
################################################################################

@export var actor: Node2D

var index: int = -1
var areas: Array[ActionArea] = []

func _ready() -> void:
	area_entered.connect(_register)
	area_exited.connect(_deregister)

func _register(area: Area2D) -> void:
	if (area is ActionArea):
		print("register " + str(area.get_instance_id()))
		area.on_entered(actor)
		areas.push_back(area)
		if (areas.size() == 1):
			_set_selected(0, actor)
	
func _deregister(area: Area2D) -> void:
	if (area is ActionArea):
		print("deregister " + str(area.get_instance_id()))
		area.on_exited(actor)
		
		var delete_index: int = areas.find(area)
		
		var new_index: int
		if (areas.size() == 1):
			new_index = -1
		elif (delete_index == index):
			new_index = _compute_index(-1)
		else:
			new_index = index
			
		_set_selected(new_index, actor)
		areas.remove_at(delete_index)

		# Deleting index before selected index, decrement selected index
		if (delete_index < index):
			index -= 1

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("perform_action")):
		_perform_action()
	if (event.is_action_pressed("prev_action") && areas.size() > 1):
		_set_selected(_compute_index(-1), actor)
	if (event.is_action_pressed("next_action") && areas.size() > 1):
		_set_selected(_compute_index(1), actor)

func _is_valid_index(index: int) -> bool:
	return index >= 0 && index < areas.size()

func _perform_action() -> void:
	if (!_is_valid_index(index)):
		return
	areas[index].perform_action(actor, "") # TODO: support different actions
	
func _compute_index(increment: int) -> int:
	if (areas.is_empty()):
		return -1

	return posmod(index + increment, areas.size())
	
func _set_selected(new_index: int, actor: Node) -> void:
	if (index == new_index):
		return
	
	if (index >= 0):
		areas[index].on_deselected(actor)

	index = new_index

	if (index >= 0):
		areas[index].on_selected(actor)
