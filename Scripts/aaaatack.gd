extends RigidBody3D

@onready var player : CharacterBody3D = $"../Player"
var attck : bool = false
var is_dead : bool = false
@onready var ray : RayCast3D = $RayCast3D 
var ded = preload("res://Assets/Audio/SFX/enemyAppearing2.mp3")

var can_attack : bool = true 
var attack_cooldown : float = 1.0 
var attack_timer : float = 0.0 

func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 1
	connect("body_entered", Callable(self, "_on_body_entered"))


func _physics_process(delta: float) -> void:
	if not can_attack:
		attack_timer += delta
		if attack_timer >= attack_cooldown:
			can_attack = true
			attack_timer = 0.0

	if global_position.distance_to(player.global_position) < 5.0:
		attck = true
	
	if attck:
		if player.spring_arm_pivot.picked && player.spring_arm_pivot.pickedObject == self:
			pass
		else:
			if ray.is_colliding():
				var direction = (player.global_position - global_position).normalized()
				direction.y = 0
				var speed = 1.5 
				linear_velocity.x = direction.x * speed
				linear_velocity.z = direction.z * speed
			else:
				linear_velocity.x = 0
				linear_velocity.z = 0

	if global_position.y < -3 and not is_dead:
		is_dead = true
		dead()

func _on_body_entered(body: Node) -> void:
	if body == player and attck and can_attack:
		player.hit(2)
		can_attack = false


func dead():
	AudioManager.play_sfx(ded)
	get_parent().get_node("Console").start("res://Resources/Dialogs/OUT/4.txt")
	queue_free()
	print("Стульчик умер")
