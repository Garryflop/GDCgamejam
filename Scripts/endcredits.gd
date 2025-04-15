extends Control

var sfx = preload("res://Assets/Audio/SFX/wow.mp3")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioManager.play_sfx(sfx)




func _on_back_button_up() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu/intro.tscn")
