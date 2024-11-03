class_name Wall extends StaticBody2D

@export var shift_position: Vector2 = Vector2.ZERO
@export var shift_size: Vector2 = Vector2.ZERO
@export var shift_duration: float = 1.0
@export var is_shifted: bool = false

var can_shift = false

@onready var color_rect: ColorRect = $ColorRect
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var trigger_area: Area2D = $TriggerArea

# TODO:
# 1. multiple shifts
# 2. different triggers
#      when off-screen
#      when on screen
#      afer timer
#      after some event (e.g.: push button)
# 3. instantaneous vs animation

func _ready() -> void:
	visible_on_screen_notifier_2d.screen_exited.connect(_set_can_shift)
	trigger_area.area_entered.connect(_shift)
	
	# Set collision shape to colored rectangle
	var rect_shape: RectangleShape2D = RectangleShape2D.new()
	rect_shape.size = color_rect.size
	collision_shape_2d.shape = rect_shape
	collision_shape_2d.global_position = global_position + color_rect.size / 2
	
	# Set visible on screen notifier to colored rectangle
	visible_on_screen_notifier_2d.scale = Vector2.ONE
	visible_on_screen_notifier_2d.rect = color_rect.get_rect()

func _set_can_shift() -> void:
	can_shift = true

func _shift(area: Area2D) -> void:
	if (is_shifted || !can_shift):
		return

	var tween: Tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "global_position", shift_position, shift_duration)
	tween.tween_property(color_rect, "size", shift_size, shift_duration)
	tween.tween_property(collision_shape_2d.shape, "size", shift_size, shift_duration)
	tween.tween_property(collision_shape_2d, "global_position", shift_position + shift_size / 2, shift_duration)
	await tween.finished

	is_shifted = true
