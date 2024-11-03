extends Node2D

func _unhandled_input(event: InputEvent) -> void:
	if (Input.is_key_pressed(KEY_N)):
		_transition()
	if (Input.is_key_pressed(KEY_M)):
		ScreenShaderManager.start([ShaderGlitch.new(5.0)])

func _transition() -> void:
	await ScreenShaderManager.start([
		ShaderBlur.new(0.0, 5.0, 3.0),
		ShaderColorFade.new(Color.RED, 0.0, 1.0, 5.0)
	])
	await ScreenShaderManager.start([
		ShaderBlur.new(5.0, 5.0, 2.0),
		ShaderColorFade.new(Color.RED, 1.0, 0.6, 2.0)
	])
	await ScreenShaderManager.start([
		ShaderBlur.new(5.0, 0.0, 3.0),
		ShaderColorFade.new(Color.RED, 0.6, 0.0, 3.0)
	])
