class_name Laser extends RayCast2D

var is_casting: bool = false:
	set (value):
		is_casting = value
		source_particles.emitting = is_casting
		beam_particles.emitting = is_casting
		set_physics_process(is_casting)
		var tween: Tween = create_tween()
		if (is_casting):
			tween.tween_property(line, "width", 5, 0.2).from(0)
		else:
			tween.tween_property(line, "width", 0, 0.1).from(5)
			destination_particles.emitting = false
	get: 
		return is_casting

@onready var line: Line2D = $Line2D
@onready var source_particles: GPUParticles2D = $SourceParticles
@onready var destination_particles: GPUParticles2D = $DestinationParticles
@onready var beam_particles: GPUParticles2D = $BeamParticles

func _ready() -> void:
	is_casting = false
	line.points[1] = Vector2.ZERO

func _physics_process(delta: float) -> void:
	var cast_point: Vector2 = target_position
	force_raycast_update()

	var is_colliding: bool = is_colliding()
	destination_particles.emitting = is_colliding
	if (is_colliding):
		cast_point = to_local(get_collision_point())
		destination_particles.global_rotation = get_collision_normal().angle()
		destination_particles.position = cast_point
		
	line.points[1] = cast_point
	beam_particles.position = cast_point * 0.5
	beam_particles.process_material.emission_box_extents.x = cast_point.length() * 0.5

func _unhandled_input(event: InputEvent) -> void:
	if (event is InputEventMouseButton):
		is_casting = event.pressed
