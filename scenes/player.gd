class_name Player extends CharacterBody2D

@export var life: int = 10
@export var speed_walk: float = 75.0
@export var speed_run: float = 150.0
@export var knockback_duration: float = 0.25

var knockback: Vector2 = Vector2.ZERO
var is_dying: bool = false # TODO: state

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var trigger_action_area: Area2D = $TriggerActionArea
@onready var inventory: CanvasLayer = $Inventory
@onready var hurtbox: Hurtbox = $Hurtbox

func _ready() -> void:
	trigger_action_area.actor = self
	hurtbox.actor = self

func _physics_process(delta: float) -> void:
	var input_vector: Vector2 = Vector2(
			Input.get_axis("ui_left", "ui_right"),
			Input.get_axis("ui_up", "ui_down"))
	
	var is_running: bool = Input.is_action_pressed("player_run")	
	var speed: float = speed_run if is_running else speed_walk
	velocity = lerp(velocity, input_vector * speed, 0.4) + knockback

	move_and_slide()

func _input(event: InputEvent) -> void:
	if (Input.is_action_just_pressed("inventory")):
		_show_hide_inventory()
		#SceneManager.signal_transition_file.emit(
		#	"res://scenes/main.tscn",
		#	TransitionColorFade.new(Color(0, 0, 0, 0), Color(0, 0, 0, 1), 2.0),
		#	TransitionColorFade.new(Color(0, 0, 0, 1), Color(0, 0, 0, 0), 2.0))
		#SceneManager.signal_transition_file.emit(
		#	"res://scenes/main.tscn",
		#	null,
		#	TransitionSlide.new(Vector2(320, 0), Vector2.ZERO, 2.0),
		#	SceneManager.Mode.FREE_AFTER)		
		
	#if (Input.is_action_just_pressed("switch_camera")):
	#	if (player_camera.is_current()):
	#		camera_2d.make_current()
	#	else:
	#		player_camera.make_current()

func _show_hide_inventory() -> void:
	if inventory.visible:
		var tween: Tween = create_tween()
		tween.tween_property(inventory, "offset", Vector2(0.0, 200.0), 1)
		await tween.finished
		inventory.visible = !inventory.visible
	else:
		inventory.visible = !inventory.visible
		var tween: Tween = create_tween()
		tween.tween_property(inventory, "offset", Vector2(0.0, 0.0), 1).from(Vector2(0.0, 200.0))
		await tween.finished

func take_damage(hitbox: Hitbox, damage: int) -> void:
	if (is_dying):
		return
		
	life -= damage
	print("life = " + str(life))
	
	if (life <= 0):
		_die()
	else:
		_handle_hit(hitbox, damage)
	
func _handle_hit(hitbox: Hitbox, damage: float) -> void:
	#ShaderManager.perform(sprite_2d, ShaderFlash.new(Color.RED, 0.25))
	ShaderManager.perform(sprite_2d, ShaderAboration.new(1, 10))
	var knockback_vector: Vector2 = (global_position - hitbox.global_position).normalized() * damage * 200.0
	var tween: Tween = create_tween()
	tween.tween_property(self, "knockback", Vector2.ZERO, knockback_duration).from(knockback_vector)
	AudioManager.play_audio("res://audio/player_hit.wav")

func _die() -> void:
	AudioManager.stop_music()
	is_dying = true

	AudioManager.play_audio("res://audio/player_die.wav")
	speed_walk = 0
	speed_run = 0
	
	var tween: Tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "scale", Vector2.ZERO, 0.5)
	tween.tween_property(self, "rotation_degrees", 720, 0.5)
	await tween.finished

	# TODO: emit dead, have game/2.0_game/game.gd listen for signal, transition scene
	SceneManager.signal_transition_file.emit(
		"res://game/3_end/end_screen.tscn",
		TransitionColorFade.new(Color(0, 0, 0, 0), Color(0, 0, 0, 1), 1),
		TransitionColorFade.new(Color(0, 0, 0, 1), Color(0, 0, 0, 0), 1)
	)

func add_to_inventory(resource: Resource) -> void:
	print("Add " + resource.name + " to inventory")
	# TODO: add inventory
	resource.action(self, "use"); #TODO: test
