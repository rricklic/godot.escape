extends Node2D

func _ready() -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if (Input.is_key_pressed(KEY_Q)):
		AudioManager.play_audio("res://audio/click.wav")
	if (Input.is_key_pressed(KEY_W)):
		AudioManager.play_audio("res://audio/player_die.wav")
	if (Input.is_key_pressed(KEY_E)):
		AudioManager.play_audio("res://audio/player_hit.wav")
	if (Input.is_key_pressed(KEY_R)):
		AudioManager.play_music("res://audio/music.wav")
	if (Input.is_key_pressed(KEY_T)):
		AudioManager.stop_music()
	if (Input.is_key_pressed(KEY_Y)):
		AudioManager.pause_music()
