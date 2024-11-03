class_name HitboxObject extends Node2D

@export var damage: int = 1

@onready var hitbox: Hitbox = $Hitbox

func _ready() -> void:
	hitbox.action_func = _take_damage
	
func _take_damage(actor: Node2D) -> void:
	if (actor is Player):
		var player: Player = actor
		player.take_damage(hitbox, damage)
