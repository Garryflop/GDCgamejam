extends RigidBody3D
@onready var player : CharacterBody3D = $"../Player"
var attck : bool = false

func _physics_process(delta: float) -> void:
	if(global_position.distance_to(player.global_position) < 5.0):
		attck = true
	if(attck):
		set_linear_velocity(global_position.direction_to(player.global_position))		
