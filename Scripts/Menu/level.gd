extends Node3D

var levelPassedSfx = preload("res://Assets/Audio/SFX/LevelPassed.mp3")
var levelMusic = preload("res://Assets/Audio/Music/noise1.mp3")
@export var pause_menu_packed : PackedScene


func _ready() -> void:
	AudioManager.play_music(levelMusic)

func _on_pause_button_released() -> void:
	var current_menu = pause_menu_packed.instantiate()
	get_tree().current_scene.call_deferred("add_child", current_menu)
	get_tree().paused = true
