extends StaticBody3D

@export var door: Node3D
@onready var anim = $AnimationPlayer

var pressed_sfx = preload("res://Assets/Audio/SFX/step.mp3")

func _on_zone_body_entered(body: Node3D) -> void:
	if body.is_in_group("rigids"):
		AudioManager.play_sfx(pressed_sfx)
		anim.play("pressed")
		door.open()


func _on_zone_body_exited(body: Node3D) -> void:
	if body.is_in_group("rigids"):
		anim.play("RESET")
