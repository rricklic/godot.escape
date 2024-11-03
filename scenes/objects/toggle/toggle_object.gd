class_name ToggleObject extends Node2D

@export var on_color: Color = Color.RED
@export var off_color: Color = Color.BLUE

var is_on: bool = false:
	set(value):
		is_on = value
		_show_color()

@onready var action_area: ActionArea = $ActionArea
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var indicator: Sprite2D = $Indicator

func _ready() -> void:
	action_area.action_func = _toggle
	action_area.on_selected_func = _pulse
	action_area.on_deselected_func = _hide
	_show_color()

func _show_color() -> void:	
	sprite_2d.modulate = on_color if is_on else off_color

func _toggle(actor: Node2D, action: String) -> void:
	print("ACTION %d" % action_area.get_instance_id())
	is_on = !is_on
	AudioManager.play_audio("res://audio/click.wav")

func _pulse(actor: Node2D) -> void:
	print("SELECT %d" % action_area.get_instance_id())
	indicator.show()
	await create_tween().tween_property(sprite_2d, "scale", Vector2(1.1, 1.1), 0.1).finished
	await create_tween().tween_property(sprite_2d, "scale", Vector2(1.0, 1.0), 0.1).finished

func _hide(actor: Node2D) -> void:
	print("DESELECT %d" % action_area.get_instance_id())
	indicator.hide()
