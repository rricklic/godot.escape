class_name DialogueObject extends Node2D

@export var text: String
@export var responses: Array[String]

const DIALOGUE_BOX_FILEPATH: String = "res://scenes/dialogue/dialogue_box.tscn"

var dialogue_box: DialogueBox

@onready var action_area: ActionArea = $ActionArea

func _ready() -> void:
	action_area.action_func = _interact
	action_area.on_exited_func = _end_interaction

func _interact(actor: Node2D, action: String) -> void:
	if (dialogue_box == null):
		dialogue_box = load(DIALOGUE_BOX_FILEPATH).instantiate()
		dialogue_box.text = text
		dialogue_box.responses = responses
		add_child(dialogue_box)
	
	var result: Dictionary = dialogue_box.interact()
	if (result.has("response")):
		print("result = " + str(result))

func _end_interaction(actor: Node2D) -> void:
	if (dialogue_box != null):
		dialogue_box.end_interaction()
		dialogue_box.queue_free()
		dialogue_box = null
	
# TODO: not in here...	
func _input(event: InputEvent) -> void:
	if (dialogue_box == null):
		return
	
	var increment: int = Input.get_axis("ui_up", "ui_down")
	dialogue_box.next_response(increment)
