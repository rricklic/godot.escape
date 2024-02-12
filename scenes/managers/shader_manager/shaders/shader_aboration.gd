class_name ShaderAboration extends ShaderBase

const shader: Shader = preload("res://shaders/aboration.gdshader")

var duration: float = 2.0
var amount: float = 10.0

func _init(duration: float, amount: float) -> void:
	self.duration = duration
	self.amount = amount
	
func perform(node: Node2D) -> void:
	var shader_material: ShaderMaterial = create_shader_material(shader)
	shader_material.set_shader_parameter("offset", 0.0)
	
	node.material = shader_material
	
	#for i in range(0, 2):
	var tween: Tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_BOUNCE)
	tween.tween_method(_set_offset.bind(shader_material), amount, 0.0, duration)
#	tween.tween_method(_set_offset.bind(shader_material), 5.0, 0.0, 0.25)
#	tween.tween_method(_set_offset.bind(shader_material), 0.0, -5.0, 0.25)
#	tween.tween_method(_set_offset.bind(shader_material), -5.0, 0.0, 0.25)
	await tween.finished
	
	node.material = null

func _set_offset(offset: float, shader_material: ShaderMaterial) -> void:
	shader_material.set_shader_parameter("offset", offset)
