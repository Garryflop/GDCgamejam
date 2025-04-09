extends CanvasLayer



func headphone():
	AudioManager.current_music_player.pitch_scale = 0.7
	AudioManager.set_global_volume(-35)


func end():
	AudioManager.current_music_player.pitch_scale = 1
	queue_free()
