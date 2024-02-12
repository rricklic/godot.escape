class_name MainWindow extends Node2D

var start_position: Vector2

@onready var window: Window = $Window
@onready var player: Player = $Window/Player

func _ready() -> void:
	start_position = window.position


func _process(delta: float) -> void:
	print(str(player.global_position.x) + " : " + str(global_position.x))
	if (player.global_position.x > global_position.x):
		window.position.x = start_position.x + (player.global_position.x - global_position.x)
		
	if (player.global_position.x < 0):
		window.position.x = start_position.x + player.global_position.x

	if (player.global_position.y > global_position.y):
		window.position.y = start_position.y + (player.global_position.y - global_position.y)
		
	if (player.global_position.y < 0):
		window.position.y = start_position.y + player.global_position.y
