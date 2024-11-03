class_name ClickerEnemy extends Node2D

signal signal_timeout

var is_hit: bool = false
@onready var area_2d: Area2D = $Sprite2D/Area2D
@onready var timer: Timer = $Timer
@onready var health: HealthBar = $EnemyHealth
@onready var sprite_2d: Sprite2D = $Sprite2D

func _spawn_enemy() -> void:
	sprite_2d.global_position = Vector2(randf_range(10, 310), randf_range(10, 170))
	#health.position = -global_position + Vector2(40, 0)
	is_hit = false
	_set_timer()
	
func _set_timer() -> void:
	var ratio: float = float(health.value) / health.max_value
	var delay: float
	if (ratio >= 0.75):
		delay = 2.0
	elif (ratio >= 0.5):
		delay = 1.75
	elif (ratio >= 0.25):
		delay = 1.5
	else:
		delay = 1.0
	timer.start(delay)

func _ready() -> void:
	health.set_value(100)
	area_2d.input_event.connect(_on_input_event)
	timer.timeout.connect(_on_timeout)
	_spawn_enemy()
	
func _hit() -> void:
	AudioManager.play_audio("res://audio/player_hit.wav")
	var shader: ShaderAboration = ShaderAboration.new(0.5, 10)
	ShaderManager.perform(sprite_2d, shader)
	var tween: Tween = create_tween()
	for i in range(0, 4):
		tween.tween_property(sprite_2d, "global_position", sprite_2d.global_position + Vector2(2, 0), 0.05)
		tween.tween_property(sprite_2d, "global_position", sprite_2d.global_position + Vector2(-2, 0), 0.05)
	await tween.finished
	_spawn_enemy()

func _die() -> void:
	# TODO: win
	queue_free()

func _handle_click() -> void:
	if (is_hit):
		return
		
	timer.stop()
	is_hit = true
	health.increment_value(-5) 
	
	if (health.value <= 0):
		_die()
	else:
		_hit()
	
func _on_timeout() -> void:
	signal_timeout.emit()
	_spawn_enemy()
	
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !(event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT):
		return
	
	var mouse_event: InputEventMouseButton = event
	if (mouse_event.pressed):
		_handle_click()
