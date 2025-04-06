extends Node


const MUSIC_MIN_DB := -80.0
const MUSIC_MAX_DB := 0.0

var music_player: AudioStreamPlayer
var sfx_player: AudioStreamPlayer

func _ready():
	music_player = AudioStreamPlayer.new()
	music_player.bus = "Музыка"
	add_child(music_player)
	
	sfx_player = AudioStreamPlayer.new()
	sfx_player.bus = "Звуковые эффекты"
	add_child(sfx_player)
	
	music_player.volume_db = MUSIC_MIN_DB

func play_music(new_stream: AudioStream, transition_time: float = 1.0) -> void:
	if music_player.playing:
		fade_out_music(transition_time)
	music_player.stream = new_stream
	music_player.volume_db = MUSIC_MIN_DB
	music_player.play()
	fade_in_music(transition_time)

func fade_in_music(duration: float) -> void:
	var tween = create_tween()
	tween.tween_property(music_player, "volume_db", MUSIC_MAX_DB, duration)


func fade_out_music(duration: float) -> void:
	var tween = create_tween()
	tween.tween_property(music_player, "volume_db", MUSIC_MIN_DB, duration)
	tween.tween_callback(Callable(music_player, "stop"))


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
