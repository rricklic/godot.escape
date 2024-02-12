class_name Icon extends Area2D

enum State {
	NONE,
	CLICK,
	DOUBLE_CLICK,
	DRAG
}

var mouse_offset: Vector2
var state: State = State.NONE
var click_threshold: float = 0.2
var last_click: float = 0.0
var last_release: float = 0.0
var window_packed = preload("res://scenes/test/space_invader_window.tscn") # TODO: "res://scenes/os/window_os.tscn"



@onready var drag_component: DragComponent = $DragComponent

func _ready() -> void:
	set_process(false)
	input_event.connect(_on_input_event)
	drag_component.drag_started.connect(_on_drag_started)
	drag_component.drag_stopped.connect(_on_drag_stopped)

func _process(delta: float) -> void:
	global_position = get_global_mouse_position() + mouse_offset

func _on_click() -> void:
	pass

func _on_double_click() -> void:
	var game: Node = window_packed.instantiate()
	get_tree().root.add_child(game)
	game.window_os.global_position = Vector2(10, 10)
	game.window_os.size = Vector2(100, 40)
	
	var tween: Tween = create_tween()
	tween.set_parallel(true)
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_QUAD)
	tween.tween_property(game.window_os, "global_position", game.window_os.global_position, 0.5).from(game.window_os.global_position + game.window_os.size / 2.0)
	tween.tween_property(game.window_os, "scale", Vector2(1, 1), 0.5).from(Vector2.ZERO)
	

func _on_drag_started() -> void:
	set_process(true)
	mouse_offset = global_position - get_global_mouse_position()

func _on_drag_stopped() -> void:
	set_process(false)

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int):
	#drag_component.handle_mouse_event(event)
	if !(event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT):
		return
	
	var mouse_event: InputEventMouseButton = event
	var now: float = Time.get_ticks_msec()
	
	print("start state = " + str(state))
	print("mouse_event.pressed = " + str(mouse_event.pressed))
	print("last_click = " + str(now - last_click))

	match state:
		State.NONE:
			if (mouse_event.pressed):
				state = State.CLICK
		State.CLICK:
			if (mouse_event.pressed &&
					(now - last_click) <= click_threshold * 1000 &&
					(now - last_release) <= click_threshold * 1000):
				state = State.DOUBLE_CLICK
				_on_double_click()
		State.DOUBLE_CLICK:
			if (!mouse_event.pressed):
				state = State.NONE
		State.DRAG:
			if (!mouse_event.pressed):
				state = State.NONE
		_: pass
	print("end state = " + str(state))
	
	
	if (mouse_event.pressed):
		last_click = now
		_on_drag_started()
	else:
		last_release = now
		_on_drag_stopped()
