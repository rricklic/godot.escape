class_name ForceUtil extends Object

static func knockback(
		global_position: Vector2,
		hit_global_position: Vector2,
		weight: float,
		speed: float
		) -> Vector2:
	return (global_position - hit_global_position).normalized() * weight * speed
