extends Area3D



func _on_body_entered(body: Node3D) -> void:
	if body is RigidBody3D:
		AudioManager.play_sfx(load("res://Assets/Audio/SFX/itemDrop.mp3"))
		$"../../Player/SpringArmPivot".picked = false
		body.set_linear_velocity(-get_global_transform().basis.x*35)
		if(body.is_in_group("Activators")):
			body.looking = true
