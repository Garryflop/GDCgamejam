extends CharacterBody3D

const LERP_VALUE: float = 0.15
const ANIMATION_BLEND: float = 7.0

@export_group("Movement variables")
@export var walk_speed: float = 1.3
@export var jump_strength: float = 15.0
@export var gravity: float = 50.0
@export var acceleration: float = 10.0
@export var deacceleration: float = 10.0

var snap_vector: Vector3 = Vector3.DOWN
var move_direction: Vector3 = Vector3.ZERO
var input_direction: Vector3 = Vector3.ZERO

@onready var player_mesh: Node3D = $Mesh
@onready var spring_arm_pivot: Node3D = $SpringArmPivot
@onready var animator: AnimationTree = $AnimationTree
@onready var camera: Camera3D = $SpringArmPivot/SpringArm3D/Camera3D

func _physics_process(delta):
	var raw_input: Vector3 = Vector3(
		-(Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")),
		0,
		-(Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up"))
	)
	raw_input = raw_input.normalized()
	input_direction = input_direction.move_toward(raw_input, delta * acceleration)
	
	if input_direction.length() > 0.1:
		set_collision_layer_value(5, true)
		set_collision_mask_value(4, true)
		set_collision_mask_value(2, false)
	else:
		set_collision_layer_value(5, false)
		set_collision_mask_value(2, true)
		set_collision_mask_value(4, false)
	
	move_direction = input_direction.rotated(Vector3.UP, rotation.y)
		
	velocity.y -= gravity * delta

	var target_velocity = move_direction * walk_speed

	var move_factor: float
	if input_direction.length() > 0.1:
		move_factor = acceleration
	else:
		move_factor = deacceleration
	
	velocity.x = lerp(velocity.x, target_velocity.x, delta * move_factor)
	velocity.z = lerp(velocity.z, target_velocity.z, delta * move_factor)

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_strength
	
	if Input.is_action_just_pressed("pick"):
		spring_arm_pivot.picked = not spring_arm_pivot.picked
		if spring_arm_pivot.picked:
			spring_arm_pivot.pick()

	var just_landed: bool = is_on_floor() and snap_vector == Vector3.ZERO
	if just_landed:
		snap_vector = Vector3.DOWN
	
	apply_floor_snap()
	move_and_slide()
	animate(delta)

func animate(delta):
	if is_on_floor():
		if velocity.length() > 0.1:
			animator.set("parameters/isWalking/blend_amount", lerp(animator.get("parameters/isWalking/blend_amount"), 1.0, delta * ANIMATION_BLEND))
			animator.set("parameters/isBackward/blend_amount", lerp(animator.get("parameters/isBackward/blend_amount"), min(-(input_direction.z - 1.0), 1.0), delta * ANIMATION_BLEND))
			animator.set("parameters/Strafe/blend_amount", lerp(animator.get("parameters/Strafe/blend_amount"), input_direction.x, delta * ANIMATION_BLEND))
		else:
			animator.set("parameters/isWalking/blend_amount", lerp(animator.get("parameters/isWalking/blend_amount"), 0.0, delta * ANIMATION_BLEND))
	else:
		animator.set("parameters/ground_air_transition/transition_request", "air")
