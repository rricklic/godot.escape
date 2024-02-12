class_name ShaderFlash extends ShaderBase

const shader: Shader = preload("res://shaders/flash.gdshader")
var color: Color
var duration: float

func _init(color: Color, duration: float) -> void:
	self.color = color
	self.duration = duration
	
func perform(node: Node2D) -> void:
	var shader_material: ShaderMaterial = create_shader_material(shader)
	shader_material.set_shader_parameter("flash_color", color)
	
	node.material = shader_material
	
	var tween: Tween = create_tween()
	tween.tween_method(_set_flash_amount.bind(shader_material), 1.0, 0.0, duration)
	await tween.finished
	
	node.material = null

func _set_flash_amount(flash_amount: float, shader_material: ShaderMaterial) -> void:
	shader_material.set_shader_parameter("flash_amount", flash_amount)
