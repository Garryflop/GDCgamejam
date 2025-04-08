extends Node3D

var levelPassedSfx = preload("res://Assets/Audio/SFX/LevelPassed.mp3")
var levelMusic = preload("res://Assets/Audio/Music/noise1.mp3")
@export var pause_menu_packed : PackedScene
@export var interactable : bool = true

func _ready() -> void:
	%TRIGGEREDPUSHBOX2.global_position.y += 10
	$SharXD6.global_position.x -= 3
	AudioManager.play_music(levelMusic)

func after()->void:
	%TRIGGEREDPUSHBOX2.global_position.y -= 10
	$SharXD6.global_position.x += 3


func _on_pause_button_released() -> void:
	if interactable:
		var current_menu = pause_menu_packed.instantiate()
		get_tree().current_scene.call_deferred("add_child", current_menu)
		get_tree().paused = true
