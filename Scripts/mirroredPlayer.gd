extends Node3D
@onready var player : CharacterBody3D = $"../../Player"
@onready var mirror : Node3D = $".."
@onready var animator : AnimationTree = $AnimationTree
@onready var root : Node3D = $".."


func _physics_process(delta: float) -> void:
	if	visible && player:
		global_position = player.global_position
		global_position.z = mirror.global_position.z - (player.global_position.z - mirror.global_position.z)
		var original_rotation = player.rotation
		rotation = Vector3(original_rotation.x, -original_rotation.y, original_rotation.z)
		if(root.mirrored):
			rotation.y -= deg_to_rad($"..".global_rotation.y+180)
		else:
			rotation.y -= deg_to_rad($"..".global_rotation.y)
		animator.set("parameters/PFBI/blend_amount", player.animator.get("parameters/PFBI/blend_amount"))
		animator.set("parameters/NFBI/blend_amount", player.animator.get("parameters/NFBI/blend_amount"))
		animator.set("parameters/NLR/blend_amount", player.animator.get("parameters/NLR/blend_amount"))
		animator.set("parameters/PLR/blend_amount", player.animator.get("parameters/PLR/blend_amount"))
		animator.set("parameters/PN/blend_amount", player.animator.get("parameters/PN/blend_amount"))
		animator.set("parameters/Air/blend_amount", player.animator.get("parameters/Air/blend_amount"))
		

func _on_visible_on_screen_enabler_3d_screen_entered() -> void:
	visible = true

func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	visible = false
