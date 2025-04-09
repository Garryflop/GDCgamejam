extends Node

const MUSIC_MIN_DB := -100.0
const MUSIC_MAX_DB := 0

var current_music_player: AudioStreamPlayer
var next_music_player: AudioStreamPlayer
var sfx_player: AudioStreamPlayer

func _ready() -> void:
	current_music_player = AudioStreamPlayer.new()
	current_music_player.bus = "Музыка"
	add_child(current_music_player)
	
	next_music_player = AudioStreamPlayer.new()
	next_music_player.bus = "Музыка"
	add_child(next_music_player)
	
	current_music_player.volume_db = MUSIC_MAX_DB
	
	sfx_player = AudioStreamPlayer.new()
	sfx_player.bus = "Звуковые эффекты"
	add_child(sfx_player)

func play_music(new_stream: AudioStream, transition_time: float = 1.0) -> void:
	if current_music_player.playing:
		fade_out_music(current_music_player, transition_time)
	
	next_music_player.stream = new_stream
	next_music_player.volume_db = MUSIC_MIN_DB
	next_music_player.play()
	fade_in_music(next_music_player, transition_time)
	
	call_deferred("swap_music_players")

func fade_in_music(player: AudioStreamPlayer, duration: float) -> void:
	var tween = create_tween()
	tween.tween_property(player, "volume_db", MUSIC_MAX_DB, duration)

func fade_out_music(player: AudioStreamPlayer, duration: float) -> void:
	var tween = create_tween()
	tween.tween_property(player, "volume_db", MUSIC_MIN_DB, duration)
	tween.tween_callback(Callable(player, "stop"))

func swap_music_players() -> void:
	var temp = current_music_player
	current_music_player = next_music_player
	next_music_player = temp

func play_sfx(stream: AudioStream, position = null) -> void:
	if position == null:
		sfx_player.stream = stream
		sfx_player.play()
	else:
		var sfx_3d := AudioStreamPlayer3D.new()
		sfx_3d.stream = stream
		sfx_3d.transform.origin = position
		add_child(sfx_3d)
		sfx_3d.play()
		sfx_3d.finished.connect(Callable(self, "_on_sfx_finished").bind(sfx_3d))

func _on_sfx_finished(player: AudioStreamPlayer3D) -> void:
	if is_instance_valid(player):
		player.queue_free()

func set_global_volume(db: float) -> void:
	var music_bus_index = AudioServer.get_bus_index("Музыка")
	AudioServer.set_bus_volume_db(music_bus_index, db)
