class_name HitboxObject extends Node2D

@export var damage: int = 1

@onready var hitbox: Hitbox = $Hitbox

func _ready() -> void:
	hitbox.action = _action
	hitbox.stop = _stop_action
	
func _action(actor: Node2D) -> void:
	if (actor is Player):
		var player: Player = actor
		player.take_damage(hitbox, damage)
		
func _stop_action(actor: Node2D) -> void:
	pass
