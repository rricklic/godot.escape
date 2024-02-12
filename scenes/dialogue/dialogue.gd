class_name Dialogue extends RefCounted

var text: String
var responses: Array[String]
var next_dialogues: Array[Dialogue]

func _init(text: String) -> void:
	self.text = text

func add_response(response: String, next_dialogue: Dialogue = null) -> void:
	responses.push_back(response)
	next_dialogues.push_back(next_dialogue)

func get_next_dialogue(response: String) -> Dialogue:
	var index: int = responses.find(response)
	return next_dialogues[index] if index >= 0 else null
