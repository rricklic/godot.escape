class_name DialogueTree extends Node2D

var first_dialogue_box: DialogueBox

# Response String -> DialogueBox
var dialogue_tree: Dictionary 

func set_first_dialogue(dialogue_box: DialogueBox) -> void:
	first_dialogue_box = dialogue_box

func add_dialogue(response: String, dialogue_box: DialogueBox) -> void:
	dialogue_tree[response] = dialogue_box

func next_dialogue(response: String) -> DialogueBox:
	return dialogue_tree[response]
