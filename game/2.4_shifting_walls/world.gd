class_name WallWorld extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var camera_ex_2d: CameraEx2D = $CameraEx2D


func _ready() -> void:
	camera_ex_2d.add_target(player)
