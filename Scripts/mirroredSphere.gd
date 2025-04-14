extends Node3D
@onready var mirror : Node3D = $".."
@onready var orig = mirror.origBody

func _ready() -> void:
	if mirror.stul:
		$Chair.visible = true
		$MirroredSphere.visible = false

func _physics_process(delta: float) -> void:
	if(visible):
		global_position = orig.global_position
		global_position.z = mirror.global_position.z - (orig.global_position.z - mirror.global_position.z)
		var original_rotation = orig.rotation
		rotation = Vector3(original_rotation.x, -original_rotation.y, original_rotation.z)
		rotation.y -= deg_to_rad($"..".global_rotation.y)
		


func _on_visible_on_screen_notifier_3d_screen_entered() -> void:
	visible = true


func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	visible = false
