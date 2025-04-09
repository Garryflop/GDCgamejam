extends StaticBody3D

@export var door: Node3D
@export var switch: bool
@onready var anim = $AnimationPlayer


var pressed_sfx = preload("res://Assets/Audio/SFX/step.mp3")

func _on_zone_body_entered(body: Node3D) -> void:
	if body is RigidBody3D:
		AudioManager.play_sfx(pressed_sfx)
		anim.play("pressed")
		door.open()


func _on_zone_body_exited(body: Node3D) -> void:
	if body is RigidBody3D && !switch:
		anim.play("RESET")
		door.close()
