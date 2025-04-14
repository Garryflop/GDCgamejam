extends StaticBody3D

@export var door: Node3D
@export var switch: bool
@export var needpush: bool
@onready var anim = $AnimationPlayer
@export var anticheeze_type : int = 0

var pressed_sfx = preload("res://Assets/Audio/SFX/step.mp3")
var cheeze = preload("res://Assets/Audio/SFX/drop.mp3")

func _on_zone_body_entered(body: Node3D) -> void:
	if body is RigidBody3D:
		if anticheeze_type == 1:
			if(global_position.y > $"../Player".global_position.y):
				print("CHEEZE")
				$"../Player/SpringArmPivot".picked = false
				body.set_linear_velocity(Vector3(2.0, 2.0, 2.0))
			else:
				opn()	
		elif anticheeze_type == 2:
			if(!body.pushed):
				print("CHEEZE")
				$"../Player/SpringArmPivot".picked = false
				body.set_linear_velocity(Vector3(2.0, 12.0, 2.0))
			else:
				opn()
		elif anticheeze_type == 3:
			if(!body.pushed):
				print("CHEEZE")
			else:
				opn()
		else:
			opn()

func opn():
	AudioManager.play_sfx(pressed_sfx)
	anim.play("pressed")
	door.open()	

func _on_zone_body_exited(body: Node3D) -> void:
	if body is RigidBody3D && !switch:
		anim.play("RESET")
		door.close()
