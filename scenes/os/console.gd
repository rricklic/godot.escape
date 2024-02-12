class_name Console extends Control

@export var message_buffer_limit: int = 100 

var message_buffer: PackedStringArray = [] 
var is_input_enabled: bool = true

@onready var rich_text_label: RichTextLabel = $VBoxContainer/ScrollContainer/RichTextLabel
@onready var line_edit: LineEdit = $VBoxContainer/HBoxContainer/LineEdit
@onready var h_box_container: HBoxContainer = $VBoxContainer/HBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	h_box_container.visible = is_input_enabled
	line_edit.text_submitted.connect(_on_input_entered)
	line_edit.grab_focus()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _push_message(message: String) -> void:
	message_buffer.push_back(message)
	if (message_buffer.size() > message_buffer_limit):
		message_buffer.remove_at(0)
	rich_text_label.text = "\n".join(message_buffer) # TODO: append_text
		
func _clear_display() -> void:
	message_buffer = []
	rich_text_label.text = ""
	
func _on_input_entered(text: String) -> void:
	line_edit.clear()
	if (text.length() == 0):
		return
	_push_message(text)
