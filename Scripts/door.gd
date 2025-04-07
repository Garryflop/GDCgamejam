extends Node3D

@export var is_open: bool = false
var sfx = preload("res://Assets/Audio/SFX/door.mp3")
func _ready() -> void:
	if is_open:
		$AnimationPlayer.play("OPENED")
	else:
		$AnimationPlayer.play("RESET")

func open():
	$AnimationPlayer.play("DoorOpen")
	AudioManager.play_sfx(sfx, self.global_position)
	is_open = true

func close():
	$AnimationPlayer.play_backwards("DoorOpen")
	is_open = false
