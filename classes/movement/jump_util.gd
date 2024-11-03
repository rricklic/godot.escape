class_name JumpUtil extends Object

#@export var JUMP_HEIGHT: float = 100.0
#@export var JUMP_TIME_PEAK: float = 0.5
#@export var JUMP_TIME_LAND: float = 0.4

#var _jump_velocity: float = (2.0 * JUMP_HEIGHT) / JUMP_TIME_PEAK * -1.0
#var _jump_gravity: float = -(2.0 * JUMP_HEIGHT) / (JUMP_TIME_PEAK * JUMP_TIME_PEAK) * -1.0
#var _fall_gravity: float = -(2.0 * JUMP_HEIGHT) / (JUMP_TIME_LAND * JUMP_TIME_LAND) * -1.0

#func calc_gravity() -> float:
#	return _jump_gravity if (_node.velocity.y < 0.0) else _fall_gravity


static func jump(
		node: Node2D,
		is_start_jump: bool,
		jump_velocity: float,
		gravity: float,
		delta: float
		) -> void:
	var input_vector: Vector2 = Vector2.ZERO
	input_vector.y += gravity * delta
	
	if (is_start_jump):
		input_vector.y = jump_velocity
	
	node.velocity = input_vector
	node.move_and_slide()
