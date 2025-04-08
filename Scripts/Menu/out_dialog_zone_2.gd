extends Area3D

@export_file("*.txt") var file: String
@export var is_out : bool = false
@export var comix : PackedScene
var drive_music = preload("res://Assets/Audio/Music/drive.mp3")
var current_volume: float

func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		get_parent().get_parent().interactable = false
		AudioManager.play_music(drive_music, 0)
		current_volume = AudioManager.current_music_player.volume_db
		AudioManager.set_global_volume(-30.0)
		get_parent().get_parent().get_node("Console").start(file)
		await get_tree().create_timer(4.4).timeout
		var current_scene = comix.instantiate()
		get_parent().get_parent().add_child(current_scene)
		await get_tree().create_timer(36.0).timeout
		get_parent().get_parent().get_node("Console").start("res://Resources/Dialogs/OUT/2.2.txt")
		get_parent().get_parent().after()
		queue_free()
