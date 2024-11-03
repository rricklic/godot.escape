class_name MeleeAttack extends Area2D

@export var input: String = "ui_accept"
@export var active_time: float = 1.0

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var active_timer: Timer = $Timer

func _ready() -> void:
	_disable()
	active_timer.timeout.connect(_disable)

func _physics_process(delta: float) -> void:
	pass

func _process(delta: float) -> void:
	pass
	
func _unhandled_input(event: InputEvent) -> void:
	if (Input.is_action_just_pressed(input)):
		_enable()
		active_timer.start(active_time)

func _enable() -> void:
	collision_shape_2d.disabled = false

func _disable() -> void:
	collision_shape_2d.disabled = true
