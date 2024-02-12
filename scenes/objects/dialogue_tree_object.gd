class_name DialogueTreeObject extends Node2D

const DIALOGUE_BOX_FILEPATH: String = "res://scenes/dialogue/dialogue_box.tscn"

var start_dialogue: Dialogue
var current_dialogue: Dialogue
var dialogue_box: DialogueBox

@onready var action_area: ActionArea = $ActionArea

func _ready() -> void:
	action_area.action_func = _interact
	action_area.on_exited_func = _end_interaction

func _setup_dialogue() -> void:
	start_dialogue = Dialogue.new("Hello, world!")
	var dialogue2: Dialogue = Dialogue.new("There are some who call me... Tim?")
	var dialogue3: Dialogue = Dialogue.new("Good bye!")
	var dialogue4: Dialogue = Dialogue.new("I am an enchanter")
	var dialogue5: Dialogue = Dialogue.new("None of your business!")
	start_dialogue.add_response("What is your name?", dialogue2)
	start_dialogue.add_response("I must go, bye.", dialogue3)
	dialogue2.add_response("What do you do?", dialogue4)
	dialogue2.add_response("Where do you live?", dialogue5)
	# TODO: how to loop back to start_dialogue on no response dialogue...
	#dialogue4.add_response("", start_dialogue)

func _interact(actor: Node2D, action: String) -> void:
	if (dialogue_box == null):
		_setup_dialogue()
		current_dialogue = start_dialogue
		dialogue_box = DialogueBox.create(start_dialogue.text, start_dialogue.responses)
		add_child(dialogue_box)
	
	var result: Dictionary = dialogue_box.interact()
	if (result.has("response")):
		_handle_next_dialogue(actor, result["response"])
	
func _handle_next_dialogue(actor: Node2D, response: String) -> void:
	print("chosen response = " + response)
	current_dialogue = current_dialogue.get_next_dialogue(response)
	if (current_dialogue):
		dialogue_box.text = current_dialogue.text
		dialogue_box.responses = current_dialogue.responses
		dialogue_box.interact()
	else:
		_end_interaction(actor)

func _end_interaction(actor: Node2D) -> void:
	if (dialogue_box != null):
		dialogue_box.end_interaction()
		dialogue_box.queue_free()
		dialogue_box = null
		start_dialogue = null
		
# TODO: not in here...	
func _input(event: InputEvent) -> void:
	if (dialogue_box == null):
		return
	
	var increment: int = Input.get_axis("ui_up", "ui_down") # TODO: float percision...
	dialogue_box.next_response(increment)
