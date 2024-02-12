extends Node

################################################################################
# Description: 
#
# Use: Set as Autoload (Project -> Project Settings -> Autoload)
################################################################################

signal signal_transition_file(scene_path: String)
signal signal_transition_packed_scene(packed_scene: PackedScene)
signal signal_transition_cache()

enum Mode {
	FREE,
	FREE_AFTER,
	HIDE,
	CACHE,
	CACHE_REMOVE,
	PAUSE,
	UNPAUSE
}

var current_scene: Node
var scene_cache: Dictionary # String -> Node
var scene_mode_cache: Dictionary # String -> ProcessMode

@onready var transition_manager: TransitionManager = $TransitionManager

func set_current_scene(current_scene: Node):
	self.current_scene = current_scene

func _ready():
	signal_transition_file.connect(_transition_scene_file)
	signal_transition_packed_scene.connect(_transition_scene_packed_scene)
	signal_transition_cache.connect(_transition_scene_cache)
		
func _transition_scene_file(
		scene_path: String,
		transition_before: Transition,
		transition_after: Transition,
		mode: Mode = Mode.FREE) -> void:
	_perform_transition(scene_path, transition_before, transition_after, mode)

func _transition_scene_packed_scene(
		packed_scene: PackedScene,
		transition_before: Transition,
		transition_after: Transition,
		mode: Mode = Mode.FREE) -> void:
	_perform_transition(packed_scene, transition_before, transition_after, mode)

func _transition_scene_cache(
		transition_before: Transition,
		transition_after: Transition,
		mode: Mode = Mode.FREE) -> void:
	var node: Node = scene_cache.values()[0]
	scene_cache.erase(node.get_instance_id())
	_perform_transition(node, transition_before, transition_after, mode)

func _perform_transition(
		variant: Variant,
		transition_before: Transition,
		transition_after: Transition,
		mode: Mode = Mode.FREE) -> void:
	if (mode == Mode.CACHE || mode == Mode.CACHE_REMOVE || mode == SceneManager.Mode.PAUSE):
		scene_mode_cache[current_scene.get_instance_id()] = current_scene.process_mode
			
	var old_scene: Node = current_scene
	var process_mode: ProcessMode = old_scene.process_mode
	old_scene.process_mode = Node.PROCESS_MODE_DISABLED

	await transition_manager.transition(current_scene, transition_before)

	var next_scene: Node
	if (variant is Node):
		next_scene = variant
	elif (variant is PackedScene):
		next_scene = _create_scene_from_packed_scene(variant)
	elif (variant is String):
		next_scene = _create_scene_from_file(variant)

	var next_process_mode: ProcessMode = next_scene.process_mode
	next_scene.process_mode = Node.PROCESS_MODE_DISABLED
	_switch_scene(next_scene, mode)
	
	await transition_manager.transition(next_scene, transition_after)
	
	if (mode == Mode.FREE_AFTER):
		old_scene.queue_free()
		
	if (scene_mode_cache.has(next_scene.get_instance_id())):
		next_scene.process_mode = scene_mode_cache[next_scene.get_instance_id()]
		scene_mode_cache.erase(next_scene.get_instance_id())
	else:
		next_scene.process_mode = next_process_mode		

func _create_scene_from_file(scene_path: String) -> Node:
	var packed_scene: PackedScene = load(scene_path)
	return _create_scene_from_packed_scene(packed_scene)

func _create_scene_from_packed_scene(packed_scene: PackedScene) -> Node:
	return packed_scene.instantiate()

func _switch_scene(next_scene: Node, mode: Mode) -> void:
	var old_scene: Node = current_scene if current_scene else get_tree().current_scene
	match mode:
		Mode.FREE:
			old_scene.queue_free()
		Mode.FREE_AFTER:
			pass
		Mode.HIDE:
			old_scene.hide()
		Mode.CACHE:
			scene_cache[old_scene.get_instance_id()] = old_scene
		Mode.CACHE_REMOVE:
			scene_cache[old_scene.get_instance_id()] = old_scene
			get_tree().root.remove(old_scene)
		Mode.PAUSE:
			get_tree().paused = true
			scene_cache[old_scene.get_instance_id()] = old_scene
		Mode.UNPAUSE:
			get_tree().paused = false
			old_scene.queue_free()
		_:
			old_scene.queue_free()
	current_scene = next_scene
	
	if (!get_tree().root.get_children().has(current_scene)):
		get_tree().root.add_child(current_scene)
