class_name Cannon extends Node2D

@export var max_speed: float = 100.0
@export_range(0.0, 1.0) var acceleration: float = 0.5
@export var cooldown: float = 0.5

var speed: float = 0.0
var bullet_packed: PackedScene = preload("res://game/2.2_space_invaders/bullet.tscn")

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var cooldown_timer: Timer = $CooldownTimer

func _physics_process(delta: float) -> void:
	var x_direction: float = Input.get_axis("ui_left", "ui_right")
	speed = lerp(speed, max_speed * x_direction, acceleration)
	var delta_x: float = speed * delta
	if (delta_x != 0):
		print(delta_x)
	global_position.x += delta_x
	
	if (Input.is_action_just_pressed("perform_action") && cooldown_timer.time_left <= 0):
		_fire_bullet()

func _fire_bullet() -> void:
	cooldown_timer.start(cooldown)
	var bullet: Bullet = bullet_packed.instantiate()
	bullet.global_position = global_position
	get_parent().add_child(bullet)
