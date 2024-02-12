class_name DialogueBox extends CanvasLayer

enum State {
	READY,
	READING,
	FINISHED
}

const INDICATOR_CHAR: String = ">"

@export var is_tween_enabled: bool = true
@export var letter_delay: float = 0.05
@export var text: String
@export var responses: Array[String]

var state: State = State.READY
var tween: Tween
var response_index: int

var h_box_containers: Array[HBoxContainer]
var indicator_labels: Array[Label]
var response_labels: Array[Label]

@onready var v_box_container: VBoxContainer = $MarginContainer/MarginContainer/VBoxContainer
@onready var dialogue_label: Label = $MarginContainer/MarginContainer/VBoxContainer/DialogueLabel
@onready var h_separator: HSeparator = $MarginContainer/MarginContainer/VBoxContainer/HSeparator

static func create(dialogue: String, responses: Array[String]) -> DialogueBox:
	var dialogue_box: DialogueBox = load("res://scenes/dialogue/dialogue_box.tscn").instantiate()
	dialogue_box.text = dialogue
	dialogue_box.responses = responses
	return dialogue_box

func _ready() -> void:
	response_index = 0

func interact() -> Dictionary:
	var response: Dictionary = {"is_done" : false} 
	match state:
		State.READY:
			_display_text()
		State.READING:
			_display_all_text()
		State.FINISHED:
			response = _end_dialogue()
	return response
	
func next_response(increment: int) -> void:
	if (state != State.FINISHED || responses.is_empty()):
		return

	indicator_labels[response_index].text = ""
	response_index = posmod(response_index + increment, responses.size())
	indicator_labels[response_index].text = INDICATOR_CHAR
	
func end_interaction() -> void:
	_display_all_text()
	_end_dialogue()
			
func _display_text() -> void:
	show()
	state = State.READING
	response_index = 0
	h_separator.hide()

	dialogue_label.text = text
	dialogue_label.visible_ratio = 0
	
	for response in responses:
		var indicator_label: Label = Label.new()
		var response_label: Label = Label.new()
		response_label.text = response
		response_label.visible_ratio = 0
		var h_box_container: HBoxContainer = HBoxContainer.new()
		h_box_container.add_child(indicator_label)
		h_box_container.add_child(response_label)
		v_box_container.add_child(h_box_container)
		
		h_box_containers.push_back(h_box_container)
		response_labels.push_back(response_label)
		indicator_labels.push_back(indicator_label)
	
	if (is_tween_enabled):
		tween = create_tween()
		tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.1).from(Vector2(0.0, 0.0))
		tween.tween_property(dialogue_label, "visible_ratio", 1, letter_delay * dialogue_label.text.length())
		for response_label in response_labels:
			tween.tween_property(response_label, "visible_ratio", 1, letter_delay * response_label.text.length())

		await tween.finished
		
		_display_indicator()

	else:
		dialogue_label.visible_ratio = 1.0
		for response_label in response_labels:
			response_label.visible_ratio = 1.0

	state = State.FINISHED
	
func _display_all_text() -> void:
	if (tween):
		tween.kill()
		tween = null
	dialogue_label.visible_ratio = 1
	for response_label in response_labels:
		response_label.visible_ratio = 1.0
	_display_indicator()

	state = State.FINISHED

func _display_indicator() -> void:
	if (!indicator_labels.is_empty()):
		indicator_labels[response_index].text = INDICATOR_CHAR
		
func _end_dialogue() -> Dictionary:
	state = State.READY
	for h_box_container in h_box_containers:
		h_box_container.queue_free()
	h_box_containers.clear()
	response_labels.clear()
	indicator_labels.clear()
	hide()

	var response: String = responses[response_index] if response_index < responses.size() else ""
	return {"response" : response, "is_done" : true}
