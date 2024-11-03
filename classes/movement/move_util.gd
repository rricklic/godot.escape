class_name MoveUtil extends Object

# clamp()
# ease() 
# smoothstep()
# remap()

# Move at constant velocity
static func move_const(
		x_axis: float,
		y_axis: float,
		speed: float,
		delta: float
		) -> Vector2:
	return Vector2(x_axis, y_axis) * speed * delta

# Linearly interpolate node from current velocity to target velocity
static func move_lerp(
		current_velocity: Vector2,
		x_axis: float,
		y_axis: float,
		speed: float,
		lerp_weight: float, # [0..1]
		delta: float # TODO: use
		) -> Vector2:
	var input_vector: Vector2 = Vector2(x_axis, y_axis).normalized()
	return lerp(current_velocity, input_vector * speed, lerp_weight) - current_velocity

static func move_accel(
			current_velocity: Vector2,
			x_axis: float,
			y_axis: float,
			delta: float,
			speed: float,
			acceleration: float
		) -> Vector2:
	var input_vector: Vector2 = Vector2(x_axis, y_axis).normalized()
	var velocity_x: float = move_toward(current_velocity.x, input_vector.x * speed, acceleration * delta)
	var velocity_y: float = move_toward(current_velocity.y, input_vector.y * speed, acceleration * delta)
	return Vector2(velocity_x, velocity_y)

static func move_tank(
		rotation: float,
		speed: float,
		delta: float
		) -> Vector2:
	return Vector2(1, 0).rotated(rotation) * speed * delta

static func move_curve(curve: Curve, duration: float) -> float:
	return curve.sample(duration)

static func follow(
		global_position: Vector2,
		target_global_position: Vector2,
		speed: float,
		delta: float
		) -> Vector2:
	return global_position.move_toward(
		target_global_position, speed * delta)

static func rotate_to(
		global_position: Vector2,
		transform: Transform2D,
		target_global_position: Vector2,
		rotation_speed: float,
		delta: float) -> float:
	var direction: Vector2 = target_global_position - global_position
	var angle_to = transform.x.angle_to(direction)
	return sign(angle_to) * min(delta * rotation_speed, abs(angle_to))
