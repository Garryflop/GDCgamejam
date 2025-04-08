extends Area3D

@export_file("*.txt") var file: String
@export var is_out : bool = false

func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		if is_out:
			get_parent().get_parent().get_node("Console").start(file)
			
