class_name Game extends Node2D

func _ready() -> void:
	AudioManager.play_music("res://audio/music.wav")

func _unpause() -> void:
	get_tree().paused = false
	call_deferred("set_process_mode", Node.PROCESS_MODE_INHERIT)

func _unhandled_key_input(event: InputEvent) -> void:
	if (Input.is_action_just_pressed("pause")):
		get_tree().paused = true
		call_deferred("set_process_mode", Node.PROCESS_MODE_DISABLED)
		get_tree().create_timer(5).timeout.connect(_unpause)
		"""
		SceneManager.signal_transition_file.emit(
			"res://scenes/game/2.1_pause/pause_screen.tscn",
			null,
			TransitionSlide.new(Vector2(0, 180), Vector2.ZERO, 0.5),
			SceneManager.Mode.PAUSE
		)
		"""
