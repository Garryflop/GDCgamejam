extends Node

# Глобальные настройки громкости
const MUSIC_MIN_DB := -80.0
const MUSIC_MAX_DB := 0.0

var music_player: AudioStreamPlayer
var sfx_player: AudioStreamPlayer

func _ready():
	# Создаем плеер для музыки
	music_player = AudioStreamPlayer.new()
	add_child(music_player)
	
	# Создаем плеер для 2D SFX
	sfx_player = AudioStreamPlayer.new()
	add_child(sfx_player)
	
	# Изначально музыка выключена
	music_player.volume_db = MUSIC_MIN_DB

# Проигрывает новую музыку с переходом (fade in/out)
func play_music(new_stream: AudioStream, transition_time: float = 1.0) -> void:
	if music_player.playing:
		fade_out_music(transition_time)
	music_player.stream = new_stream
	music_player.volume_db = MUSIC_MIN_DB
	music_player.play()
	fade_in_music(transition_time)

# Плавное увеличение громкости
func fade_in_music(duration: float) -> void:
	var tween = create_tween()
	tween.tween_property(music_player, "volume_db", MUSIC_MAX_DB, duration)

# Плавное уменьшение громкости и остановка плеера по завершении
func fade_out_music(duration: float) -> void:
	var tween = create_tween()
	tween.tween_property(music_player, "volume_db", MUSIC_MIN_DB, duration)
	tween.tween_callback(Callable(music_player, "stop"))

# Проигрывание SFX; если позиция не указана, используется 2D плеер, иначе создается временный 3D-плеер
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
		# Используем новый синтаксис для подключения сигнала "finished"
		sfx_3d.finished.connect(Callable(self, "_on_sfx_finished").bind(sfx_3d))

# Обработчик завершения воспроизведения 3D SFX
func _on_sfx_finished(player: AudioStreamPlayer3D) -> void:
	if is_instance_valid(player):
		player.queue_free()
