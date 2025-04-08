extends RigidBody3D
@onready var player : CharacterBody3D = $"../Player"
var attck : bool = false

func _physics_process(delta: float) -> void:
	if(global_position.distance_to(player.global_position) < 5.0):
		attck = true
	if(attck && player.spring_arm_pivot.pickedObject != self):
		set_linear_velocity(global_position.direction_to(player.global_position)*1.5)		
		set_linear_velocity(Vector3(linear_velocity.x, 0, linear_velocity.z))
	if(global_position.y < 10):
		dead()	
	
func dead():
	pass
