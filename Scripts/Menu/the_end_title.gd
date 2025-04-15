extends CanvasLayer

var sfx = preload("res://Assets/Audio/SFX/whooshMotion.mp3")
var mus = preload("res://Assets/Audio/Music/MainMenuTheme.mp3")

func _ready() -> void:
	AudioManager.play_music(mus)
	AudioManager.play_sfx(sfx)

func change_scene() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu/ENDcredits.tscn")
