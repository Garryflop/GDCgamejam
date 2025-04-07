extends Area3D

@export_file("*.txt") var file: String
@export var is_out : bool = false
var drive_music = preload("res://Assets/Audio/Music/drive.mp3")

func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		AudioManager.play_music(drive_music, 0.1)
		get_parent().get_parent().get_node("Console").start(file)
		await get_tree().create_timer(5.4).timeout
		get_tree().change_scene_to_file("res://Scenes/comix.tscn")
