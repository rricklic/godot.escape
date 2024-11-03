class_name PauseScreen extends Node2D

func _unhandled_key_input(event: InputEvent) -> void:
	if (Input.is_action_just_pressed("pause")):
		SceneManager.signal_transition_cache.emit(
			TransitionSlide.new(Vector2.ZERO, Vector2(0, 180), 0.5),
			null,
			SceneManager.Mode.UNPAUSE
		)
