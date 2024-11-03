class_name ItemData_R extends Resource

@export var name: String
@export_multiline var description: String
@export var texture: Texture2D

@export var on_entered_funcs: Array[ItemOnEnteredFunc_R] = []
@export var action_funcs: Array[ItemActionFunc_R] = []

func on_entered(actor: Node2D) -> void:
	for on_entered_func in on_entered_funcs:
		on_entered_func.function(actor, self)

func action(actor: Node2D, action: String) -> void:
	for action_func in action_funcs:
		action_func.function(actor, action, self)
