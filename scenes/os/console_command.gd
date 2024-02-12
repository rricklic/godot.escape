class_name ConsoleCommand extends Node

enum ArgumentType {
	FLOAT,
	INT,
	STRING
}

@export var argument_names: Array[String] = []
@export var argument_types: Array[ArgumentType] = []

var callback: Callable

func set_callback(aCallback: Callable) -> void:
	callback = aCallback

func get_callback() -> Callable:
	return callback

func _ready() -> void:
	assert(argument_types.size() == argument_names.size())
	assert(name.find(" ") == -1)
	name = name.to_lower()

func usage() -> String:
	var usage: String = "Usage: %s " % name
	for i in range(argument_types.size()):
		var arg_type = ArgumentType.keys()[argument_types[i]]
		var arg_name = argument_names[i]
		usage += "<%s:%s> " % [arg_type.to_lower(), arg_name.to_lower()]
	return usage
