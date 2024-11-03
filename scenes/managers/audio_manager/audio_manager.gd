extends Node

# Autoload AudioManager

@export var size: int = 8
const AUDIO_BUS_NAME: String = "master"

var music_player: AudioStreamPlayer
var audio_players: Array[AudioStreamPlayer] = []  # The available players.
var audio_queue: Array[String] = []  # The queue of sounds to play.
var audio_cache: Dictionary = {} # audio_resource_path: String -> audio_stream: AudioStream

func _ready():
	music_player = _create_audio_player()
	for i: int in size:
		var audio_player: AudioStreamPlayer = _create_audio_player()
		audio_players.push_back(audio_player)
		audio_player.finished.connect(_on_stream_finished.bind(audio_player))

func _create_audio_player() -> AudioStreamPlayer:
	var audio_player: AudioStreamPlayer = AudioStreamPlayer.new()
	add_child(audio_player)	
	audio_player.bus = AUDIO_BUS_NAME
	return audio_player

func _on_stream_finished(audio_player: AudioStreamPlayer):
	audio_players.push_back(audio_player)

func play_audio(audio_res: String):
	audio_queue.push_back(audio_res)

func play_music(audio_res: String):
	music_player.stream = _load_audio_stream(audio_res)
	music_player.play()
	if (!music_player.finished.is_connected(play_music.bind(audio_res))):
		music_player.finished.connect(play_music.bind(audio_res))
	await music_player.finished 

func stop_music():
	music_player.stop()
	
func pause_music():
	music_player.set_stream_paused(!music_player.get_stream_paused())

func clear_audio_cache() -> void:
	audio_cache.clear()

func _load_audio_stream(audio_res: String) -> AudioStream:
	if (!audio_cache.has(audio_res)):
		audio_cache[audio_res] = load(audio_res)
	return audio_cache[audio_res]

func _process(delta: float) -> void:
	if !audio_queue.is_empty() && !audio_players.is_empty():
		var audio_res: String = audio_queue.pop_front()
		var index: int = audio_players.size() - 1
		audio_players[index].stream = _load_audio_stream(audio_res)
		audio_players[index].play()
		audio_players.pop_back()
