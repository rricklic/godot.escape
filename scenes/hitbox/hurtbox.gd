@icon("res://images/node_icons/hurtbox_icon.png")
class_name Hurtbox extends Area2D

################################################################################
# Description: 
################################################################################

signal signal_hurt(hitBox: Hitbox)
signal signal_hurt_stop(hitBox: Hitbox)

@export var actor: Node2D

var hitboxes: Array[Hitbox]

@export var cooloff_time: float = 0.5
#@onready var hit_timer: Timer = $Timer

func _ready() -> void:
	area_entered.connect(_hitbox_entered)
	area_exited.connect(_hitbox_exited)

func _hitbox_entered(area: Area2D) -> void:
	if (area is Hitbox):
		var hitbox: Hitbox = area
		hitboxes.push_back(hitbox)
		_handle_hitbox()
		
func _hitbox_exited(area: Area2D) -> void:
	if (area is Hitbox):
		var hitbox: Hitbox = area
		var index: int = hitboxes.find(hitbox)
		hitboxes.remove_at(index)
		hitbox.stop_action(actor)
		signal_hurt_stop.emit(hitbox)
		
func _handle_hitbox() -> void:
	if (hitboxes.is_empty()):
		return
	hitboxes[0].perform_action(actor)
	signal_hurt.emit(hitboxes[0])
	get_tree().create_timer(cooloff_time, false).timeout.connect(_handle_hitbox)
	
"""
func _handle_hitbox_v2(hitbox: Hitbox) -> void:
	var index: int = hitboxes.find(hitbox)
	if (index < 0):
		return
	hitbox.perform_action(actor)
	signal_hurt.emit(hitbox)
	get_tree().create_timer(cooloff_time).timeout.connect(_handle_hitbox.bind(hitbox))
	
var timer: Timer = Timer.new() # TODO: create instance
func _handle_hitbox_v3(hitbox: Hitbox) -> void:
	var index: int = hitboxes.find(hitbox)
	if (index < 0 || !timer.is_stopped()):
		return
	hitbox.perform_action(actor)
	signal_hurt.emit(hitbox)
	timer.start(cooloff_time)
	timer.finished.connect(_handle_hitbox_v3.bind(hitbox))
"""
