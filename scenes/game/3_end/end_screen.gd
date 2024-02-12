class_name EndScreen extends Node2D

func _unhandled_key_input(event: InputEvent) -> void:
	if (Input.is_action_just_pressed("ui_accept")):
		SceneManager.signal_transition_file.emit(
			"res://scenes/game/1.0_title/title_screen.tscn",
			TransitionColorFade.new(Color(0, 0, 0, 0), Color(0, 0, 0, 1), 1),
			TransitionColorFade.new(Color(0, 0, 0, 1), Color(0, 0, 0, 0), 1)
		)
