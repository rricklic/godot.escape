class_name Bullet extends Node2D

@export var speed: float = 50.0

@onready var hitbox: Hitbox = $Hitbox

func _ready() -> void:
	hitbox.action_func = _destroy_self

func _physics_process(delta: float) -> void:
	global_position.y -= speed * delta
	
	if (global_position.y < - 50):
		_destroy_self(null)

func _destroy_self(_actor: Node2D) -> void:
	queue_free()
