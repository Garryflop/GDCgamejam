extends CharacterBody3D

const LERP_VALUE : float = 0.15

#var snap_vector : Vector3 = Vector3.DOWN
var speed : float = 1.3

@export_group("Movement variables")
@export var walk_speed : float = 1.3
@export var jump_strength : float = 10.0
@export var gravity : float = 50.0
const ANIMATION_BLEND : float = 7.0
var move_direction : Vector3 = Vector3.ZERO
var input_direction : Vector3 = Vector3.ZERO
@onready var player_mesh : Node3D = $Mesh
@onready var spring_arm_pivot : Node3D = $SpringArmPivot
@onready var animator : AnimationTree = $AnimationTree
@onready var camera : Camera3D = $SpringArmPivot/SpringArm3D/Camera3D
var savedvelocity : Vector3
var is_outside : bool = false


func _physics_process(delta):
	input_direction.x = -(Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))
	input_direction.z = -(Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up"))
	
	input_direction = input_direction.normalized()
	if(input_direction.length() > 0):
		set_collision_layer_value(5, true)
		set_collision_mask_value(4, true)
		set_collision_mask_value(2, false)
	else:
		set_collision_layer_value(5, false)
		set_collision_mask_value(2, true)
		set_collision_mask_value(4, false)
	move_direction = input_direction.rotated(Vector3.UP, rotation.y)
		
	velocity.y -= gravity * delta
	velocity.x = move_direction.x * speed
	velocity.z = move_direction.z * speed
	if Input.is_action_just_pressed("jump") and is_on_floor():
		#velocity = get_global_transform().basis.z * 3
		#velocity.z = 12
		velocity.y = jump_strength
		savedvelocity = Vector3(move_direction.x*3, jump_strength, move_direction.z*3)
	#if move_direction:
		#player_mesh.rotation.y = lerp_angle(player_mesh.rotation.y, rota, LERP_VALUE)
	elif !is_on_floor() && savedvelocity:
		velocity.x = savedvelocity.x
		velocity.z = savedvelocity.z
		
		
	if Input.is_action_just_pressed("pick"):
		if spring_arm_pivot.picked:
			spring_arm_pivot.picked = false
		else:
			spring_arm_pivot.pick()
			

			
	
	#var just_landed := is_on_floor() and snap_vector == Vector3.ZERO
	#var is_jumping := is_on_floor() and false
	#if is_jumping:
		#velocity.y = jump_strength
		#velocity = savedvelocity
		#
		#snap_vector = Vector3.ZERO
	#elif just_landed:
		#snap_vector = Vector3.DOWN
	
	apply_floor_snap()
	move_and_slide()
	animate(delta)

func animate(delta):
	if is_on_floor():
		animator.set("parameters/isAir/blend_amount", lerp(animator.get("parameters/isAir/blend_amount"), 0.0, delta * ANIMATION_BLEND))
		if velocity.length() > 0:
			animator.set("parameters/isWalking/blend_amount", lerp(animator.get("parameters/isWalking/blend_amount"), 1.0, delta * ANIMATION_BLEND))
			animator.set("parameters/isBackward/blend_amount", lerp(animator.get("parameters/isBackward/blend_amount"), min(-(input_direction.z-1.0), 1.0), delta * ANIMATION_BLEND))
			#print(animator.get("parameters/Strafe/blend_amount"))
			animator.set("parameters/Strafe/blend_amount", lerp(animator.get("parameters/Strafe/blend_amount"), -input_direction.x, delta * ANIMATION_BLEND))
		
		else:
			animator.set("parameters/isWalking/blend_amount", lerp(animator.get("parameters/isWalking/blend_amount"), 0.0, delta * ANIMATION_BLEND))
	else:
		animator.set("parameters/isAir/blend_amount", lerp(animator.get("parameters/isAir/blend_amount"), 1.0, delta * ANIMATION_BLEND))
