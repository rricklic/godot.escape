class_name TitleScreen extends Node2D

func _unhandled_key_input(event: InputEvent) -> void:
	if (Input.is_action_just_pressed("ui_accept")):
		SceneManager.signal_transition_file.emit(
			"res://game/2.0_game/game.tscn",
			TransitionColorFade.new(Color(0, 0, 0, 0), Color(0, 0, 0, 1), 1),
			TransitionColorFade.new(Color(0, 0, 0, 1), Color(0, 0, 0, 0), 1)
		)