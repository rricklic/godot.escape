class_name SpaceInvaderWindow extends Control

@onready var window_os: WindowOS = $WindowOS
@onready var scroll_container: ScrollContainer = $WindowOS/NinePatchRect/MarginContainer/Layout/Content/ScrollContainer
@onready var sub_viewport: SubViewport = $WindowOS/NinePatchRect/MarginContainer/Layout/Content/ScrollContainer/MarginContainer/SubViewportContainer/SubViewport
@onready var camera_2d: Camera2D = $WindowOS/NinePatchRect/MarginContainer/Layout/Content/ScrollContainer/MarginContainer/SubViewportContainer/SubViewport/Level/Camera2D

func _ready() -> void:
	window_os.tree_exiting.connect(_close)

func _physics_process(delta: float) -> void:
	#var h_scroll_bar: HScrollBar = scroll_container.get_h_scroll_bar()
	#var v_scroll_bar: VScrollBar = scroll_container.get_v_scroll_bar()
	#sub_viewport.size = window_os.size - Vector2(v_scroll_bar.size.x -2 , 15 + h_scroll_bar.size.y)
	
	sub_viewport.size = scroll_container.size
	var zoom: Vector2 = Vector2(sub_viewport.size.x / 320.0, sub_viewport.size.y / 180.0)
	camera_2d.zoom = zoom
	
func _close() -> void:
	queue_free()
