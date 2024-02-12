extends Node2D

################################################################################
# Description: 
#
# class_name: ShaderManager (Project -> Project Settings -> Autoload)
################################################################################

func perform(node: Node2D, shader: ShaderBase) -> void:
	if (shader == null):
		return

	add_child(shader)
	await shader.perform(node)
	shader.queue_free()
