extends RigidBody3D

@onready var player : CharacterBody3D = $"../Player"
var attck : bool = false
var is_dead : bool = false
@onready var ray : RayCast3D = $RayCast3D 
var ded = preload("res://Assets/Audio/SFX/enemyAppearing2.mp3")

var can_attack : bool = true  # Флаг для контроля частоты атак
var attack_cooldown : float = 1.0  # Время между атаками в секундах
var attack_timer : float = 0.0  # Таймер для отслеживания времени

func _ready() -> void:
	# Включаем мониторинг контактов для обнаружения столкновений
	contact_monitor = true
	max_contacts_reported = 1
	# Подключаем сигнал столкновения к функции обработки
	connect("body_entered", Callable(self, "_on_body_entered"))


func _physics_process(delta: float) -> void:
	# Обновляем таймер атаки
	if not can_attack:
		attack_timer += delta
		if attack_timer >= attack_cooldown:
			can_attack = true
			attack_timer = 0.0

	# Проверка расстояния до игрока для активации атаки
	if global_position.distance_to(player.global_position) < 5.0:
		attck = true
	
	# Логика поведения стульчика
	if attck:
		if player.spring_arm_pivot.picked && player.spring_arm_pivot.pickedObject == self:
			# Если стульчик поднят игроком, ничего не делаем
			pass
		else:
			if ray.is_colliding():
				# Если стульчик на земле, двигается к игроку
				var direction = (player.global_position - global_position).normalized()
				direction.y = 0  # Убираем вертикальную составляющую
				var speed = 1.5  # Скорость движения
				linear_velocity.x = direction.x * speed
				linear_velocity.z = direction.z * speed
			else:
				# Если стульчик в воздухе, останавливаем горизонтальное движение
				linear_velocity.x = 0
				linear_velocity.z = 0

	# Проверка падения ниже уровня
	if global_position.y < -3 and not is_dead:
		is_dead = true
		dead()

func _on_body_entered(body: Node) -> void:
	# Проверяем, столкнулся ли стульчик с игроком
	if body == player and attck and can_attack:
		# Наносим урон игроку
		player.hit(2)  # Предполагается, что у игрока есть метод take_damage
		can_attack = false  # Запрещаем повторную атаку до истечения таймера


func dead():
	AudioManager.play_sfx(ded)
	get_parent().get_node("Console").start("res://Resources/Dialogs/OUT/4.txt")
	queue_free()
	print("Стульчик умер")
