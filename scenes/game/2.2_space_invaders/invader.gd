class_name Invader extends Node2D

@onready var hurtbox: Hurtbox = $Hurtbox

var local_position: Vector2
var speed: float = 10.0
var direction: int = 1
var is_dying: bool = false

func _ready() -> void:
	local_position = global_position
	hurtbox.signal_hurt.connect(_destroy_self)
	
func _physics_process(delta: float) -> void:
	if (is_dying):
		return

	local_position.x += direction * speed * delta
	global_position.x = int(local_position.x / 10) * 10
	
func _destroy_self(hitbox: Hitbox) -> void:
	is_dying = true
	var tween: Tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "scale", Vector2.ZERO, 0.5)
	tween.tween_property(self, "rotation_degrees", 720, 0.5)
	await tween.finished
	queue_free()
