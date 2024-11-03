class_name SplashScreen extends Node2D

func _ready() -> void:
	SceneManager.current_scene = self
	await get_tree().create_timer(3.0).timeout
	SceneManager.signal_transition_file.emit(
		"res://game/1.0_title/title_screen.tscn",
		TransitionColorFade.new(Color(0, 0, 0, 0), Color(0, 0, 0, 1), 1),
		TransitionColorFade.new(Color(0, 0, 0, 1), Color(0, 0, 0, 0), 1)
	)
