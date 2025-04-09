extends Node3D
@onready var player : CharacterBody3D = $"../../Player"
@onready var mirror : Node3D = $".."
@export var mirrored : bool = false
@onready var animator : AnimationTree = $AnimationTree

func _physics_process(delta: float) -> void:
	if	visible:
		global_position = player.global_position
		global_position.z = mirror.global_position.z - (player.global_position.z - mirror.global_position.z)
		var original_rotation = player.rotation
		rotation = Vector3(original_rotation.x, -original_rotation.y, original_rotation.z)
		if(mirrored):
			rotation.y -= deg_to_rad($"..".global_rotation.y+180)
		else:
			rotation.y -= deg_to_rad($"..".global_rotation.y)
		animator.set("parameters/isWalking/blend_amount", player.animator.get("parameters/isWalking/blend_amount"))
		animator.set("parameters/isBackward/blend_amount", player.animator.get("parameters/isBackward/blend_amount"))
		animator.set("parameters/isAir/blend_amount", player.animator.get("parameters/isAir/blend_amount"))
		animator.set("parameters/Strafe/blend_amount", player.animator.get("parameters/Strafe/blend_amount"))


func _on_visible_on_screen_enabler_3d_screen_entered() -> void:
	visible = true

func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	visible = false
