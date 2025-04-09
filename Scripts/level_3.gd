extends Node3D

var levelPassedSfx = preload("res://Assets/Audio/SFX/LevelPassed.mp3")
var levelMusic = preload("res://Assets/Audio/Music/noise1.mp3")
@export var pause_menu_packed : PackedScene
@export var interactable : bool = true
@onready var sprite : ColorRect = $InputLayout/ColorRect

func _ready() -> void:
	%TRIGGEREDPUSHBOX2.global_position.y += 10
	$SharXD6.global_position.x -= 3
	AudioManager.play_music(levelMusic)

func after()->void:
	%TRIGGEREDPUSHBOX2.global_position.y -= 10
	$SharXD6.global_position.x += 3


func tween_vignette(new_alpha: float, new_inner_radius: float, new_outer_radius: float, duration: float):
	if sprite.material is ShaderMaterial:
		var tween = get_tree().create_tween()
		tween.tween_property(sprite.material, "shader_param/alpha", new_alpha, duration)
		tween.tween_property(sprite.material, "shader_param/inner_radius", new_inner_radius, duration)
		tween.tween_property(sprite.material, "shader_param/outer_radius", new_outer_radius, duration)

func reset_vignette(duration: float):
	tween_vignette(1.0, 0.0, 1.0, duration)

func _on_pause_button_released() -> void:
	if interactable:
		var current_menu = pause_menu_packed.instantiate()
		get_tree().current_scene.call_deferred("add_child", current_menu)
		get_tree().paused = true
