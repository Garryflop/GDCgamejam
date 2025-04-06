extends Node3D

@export_group("FOV")
@export var change_fov_on_run : bool
@export var normal_fov : float = 75.0
@export var run_fov : float = 90.0

const CAMERA_BLEND : float = 0.05
var picked : bool = false
@onready var spring_arm : SpringArm3D = $SpringArm3D
@onready var camera : Camera3D = $SpringArm3D/Camera3D
var start_event_pos : Vector2
var event_current_pos : Vector2
var oneclick = false
var pickedObject : RigidBody3D
var doubleTap = false

func _ready():
	pass
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
		
	if event is InputEventScreenDrag:
		event_current_pos = event.position
		$"..".rotate_y(-event.relative.x * 0.01)
		spring_arm.rotate_x(event.relative.y * 0.01)
		spring_arm.rotation.x = clamp(spring_arm.rotation.x, -PI/4, PI/4)
	

func _physics_process(_delta):
	if(picked && pickedObject):
		pickedObject.set_linear_velocity(($SpringArm3D/Camera3D/Hand.global_position - pickedObject.global_position)*4)
	
	if change_fov_on_run:
		if owner.is_on_floor():
			if Input.is_action_pressed("run"):
				camera.fov = lerp(camera.fov, run_fov, CAMERA_BLEND)
			else:
				camera.fov = lerp(camera.fov, normal_fov, CAMERA_BLEND)
		else:
			camera.fov = lerp(camera.fov, normal_fov, CAMERA_BLEND)



func pick():
	var ray_query = $SpringArm3D/Camera3D/RayCast3D.get_collider()
	if(ray_query is RigidBody3D):
		picked = true
		pickedObject = ray_query
		#pickedObject.
	
func oneClickExpired() -> void:
	doubleTap = false
