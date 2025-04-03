extends Node3D


@export var pause_menu_packed : PackedScene


func _on_pause_button_released() -> void:
	var current_menu = pause_menu_packed.instantiate()
	get_tree().current_scene.call_deferred("add_child", current_menu)
	get_tree().paused = true
