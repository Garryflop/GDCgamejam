extends RigidBody3D


func _on_body_entered(body: Node) -> void:
	if body is StaticBody3D:
		AudioManager.play_sfx(load("res://Assets/Audio/SFX/drop.mp3"))
