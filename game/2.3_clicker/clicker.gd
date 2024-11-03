class_name Clicker extends Node2D

@onready var enemy: Node2D = $Enemy
@onready var player_health: HealthBar = $PlayerHealth

func _ready() -> void:
	player_health.set_value(10)
	enemy.signal_timeout.connect(_on_enemy_timeout)
	
func _on_enemy_timeout() -> void:
	player_health.increment_value(-1)
	if (player_health.value <= 0):
		# TODO: lose
		queue_free()
		
