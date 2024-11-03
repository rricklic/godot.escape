class_name WallPolygon extends Polygon2D

@export var shift: Vector2 = Vector2.ZERO
@export var grow: Vector2 = Vector2.ZERO

var is_shifted: bool = false

@onready var color_rect: ColorRect = $ColorRect
@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	visible_on_screen_notifier_2d.screen_exited.connect(_shift)

func _shift() -> void:
	if (is_shifted):
		return
	
	global_position += shift
	color_rect.set_size(color_rect.get_size() + grow)
	is_shifted = true
