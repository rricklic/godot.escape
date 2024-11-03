class_name Key extends Node2D

@onready var action_area: ActionArea = $ActionArea

func _ready() -> void:
	action_area.on_entered_func = _pickup
	
func _pickup(actor: Node2D) -> void:
	if (actor is PlatformPlayer):
		var player: PlatformPlayer = actor
		player.add_inventory("key", null)
		queue_free()
