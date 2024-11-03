class_name Platform extends Path2D

# Standard platform
# One way platform (e.g.: jump up through)
# Conditional way platform (e.g.: jump down through when pressing down)
# Move platform: between 2 points, in one direction, using path
# Conveyor belt platform
# Platform with additional physics (e.g.: ice)
# Deteriorating platform
# Bounce pad platform
# Phasing platform

################################################################################
# Description: 
################################################################################

# Signals
#signal signal_name(foo)

# Enums
#enum EnumName {ONE, TWO, THREE}

# Constants
#const SPEED: float = 100.0

# Export variables
#@export_category("Category Name")
#@export_group("Group Name")
#@export_subgroup("Subgroup Name")
#@export_range(0.0, 100.0, 0.1)
#@export var speed: float = 200.0

# Variables
#var count: int = 0
#   set(value):
#       count = value
#   get: 
#       return count


@export var speed: float = 100.0

@onready var path_follow: PathFollow2D = $PathFollow2D

################################################################################
# CONSTRUCTOR / DESTRUCTOR
################################################################################

# Called when the object's script is instantiated, oftentimes when object is
# initialized in memory (Object.new()). It can be defined to take parameters.
# NOTE: If _init() is defined with required parameters, the Object may only be
# created directly. Other means (PackedScene.instantiate(), Node.duplicate())
# will fail.
func _init() -> void:
	pass

# Called when the node enters the SceneTree. Children _enter_tree() are called
# before parent.
# NOTE: may be called multiple times if Node is removed and re-enters SceneTree
func _enter_tree() -> void:
	pass

# Called when the node is about to leave the SceneTree (freeing, scene changing,
# or after remove_child() in a script). Children _exit_tree() called before
# parent.
func _exit_tree() -> void:
	# queue_free()
	pass

# Called when the node is ready (when both the node and its children have
# entered the scene tree). Children _ready() are called before parent.
# NOTE: _ready() is only called once for a Node
func _ready() -> void:
	pass

################################################################################
# PROCESSING
################################################################################

# Called as fast as possible, so delta is not constant
func _process(delta: float) -> void:
	pass

# Called in sync with frame rate (1/60th second), so delta should be constant
func _physics_process(delta: float) -> void:
	path_follow.progress += delta * speed

################################################################################
# INPUT
################################################################################

# Called when there is an input event. The input event propagates up through the
# node tree until a node consumes it: Viewport.set_input_as_handled() .
func _input(event: InputEvent) -> void:
	pass

# Called when an input event hasn't been consumed by _input(). The input event
# propagates up through the node tree until a node consumes it.
func _shortcut_input(event: InputEvent) -> void:
	pass
	
# Called when an input event hasn't been consumed by _input() or any GUI Control
# item. It is called after _shortcut_input() but before _unhandled_input(). The
# input event propagates up through the node tree until a node consumes it.
func _unhandled_key_input(event: InputEvent) -> void:
	pass

# Called when an input event hasn't been consumed by _input() or any GUI Control
# item. It is called after _shortcut_input() and after _unhandled_key_input().
# The input event propagates up through the node tree until a node consumes it.
func _unhandled_input(event: InputEvent) -> void:
	pass

func _notification(what: int) -> void:
	pass

################################################################################
# RENDERING
################################################################################

# Called when CanvasItem has been requested to redraw (after queue_redraw()
func _draw() -> void:
	pass
