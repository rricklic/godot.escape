class_name Invaders extends Node2D

var invader_packed: PackedScene = preload("res://scenes/game/2.2_space_invaders/invader.tscn")

func _ready() -> void:
	for row in range(0, 10):
		for col in range(0, 4): 
			var invader: Invader = invader_packed.instantiate()
			invader.global_position = Vector2(60 + row * 20, col * 20)
			add_child(invader)

func _physics_process(delta: float) -> void:
	var is_move_down: bool = false
	for node in get_children():
		if (node is Invader && node.global_position.x < 20 || node.global_position.x > 300):
			is_move_down = true
			break

	if (!is_move_down):
		return
		
	for node in get_children():
		if (node is Invader):
			node.global_position.x = clamp(node.global_position.x, 20, 300)
			node.global_position.y += 10
			node.direction *= -1
