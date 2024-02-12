class_name ShaderBase extends Node2D
	
func perform(node: Node2D) -> void:
	pass
	
func create_shader_material(shader: Shader) -> ShaderMaterial:
	var shader_material: ShaderMaterial = ShaderMaterial.new()
	shader_material.shader = shader
	shader_material.resource_local_to_scene = true
	return shader_material;
