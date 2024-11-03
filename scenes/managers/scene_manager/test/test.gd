extends Node2D

func _ready() -> void:
	SceneManager.transition_scene_file("res://scenes/managers/scene_manager/test/scene1.tscn",
	null, 
	TransitionColorFadeShader.new(Color.BLACK, 1.0, 0.0, 3.0))

func _unhandled_input(event: InputEvent) -> void:
	if (Input.is_key_pressed(KEY_N)):
		SceneManager.transition_scene_file2("res://scenes/managers/scene_manager/test/scene1.tscn", 
			[TransitionColorFadeShader.new(Color.RED, 0.0, 1.0, 2.0), TransitionBlurShader.new(0.0, 5.0, 2.0)],
			[TransitionColorFadeShader.new(Color.RED, 1.0, 0.0, 2.0), TransitionBlurShader.new(5.0, 0.0, 2.0)])
	if (Input.is_key_pressed(KEY_M)):
		SceneManager.transition_scene_file2("res://scenes/managers/scene_manager/test/scene2.tscn", 
			[TransitionColorFadeShader.new(Color.BLUE, 0.0, 1.0, 2.0), TransitionSlide.new(Vector2(0, 0), Vector2(320, 0), 2.0)],
			[TransitionColorFadeShader.new(Color.BLUE, 1.0, 0.0, 2.0), TransitionSlide.new(Vector2(320, 0), Vector2(0, 0), 2.0)])
