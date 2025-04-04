extends Node3D


@export var pause_menu_packed : PackedScene


func _on_pause_button_released() -> void:
	var current_menu = pause_menu_packed.instantiate()
	get_tree().current_scene.call_deferred("add_child", current_menu)
	get_tree().paused = true


func _on_zone_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		$Console.start("res://Resources/Dialogs/dialogText1.txt")


func _on_zone_2_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		$Console.start("res://Resources/Dialogs/dialogText2.txt")
