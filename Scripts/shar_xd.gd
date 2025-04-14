extends RigidBody3D
var pushed : bool = false

func colided(body: Node) -> void:
	if body.is_in_group("obsticles"):
		pushed = false
