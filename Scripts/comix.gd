extends CanvasLayer


var current_volume: float

func headphone():
	current_volume = AudioManager.music_player.volume_db
	AudioManager.music_player.pitch_scale = 0.7
	AudioManager.music_player.volume_db -= 10


func end():
	AudioManager.music_player.volume_db = current_volume
	AudioManager.music_player.pitch_scale = 1
