extends Area3D

@export_file("*.txt") var file: String
@export var door: Node3D
@export var door2: Node3D

func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		get_parent().get_parent().get_node("Console").start(file)
		await get_tree().create_timer(5.2).timeout
		if !door.is_open:
			door.open()
			if(door2):
				door2.open()
		queue_free()
				
