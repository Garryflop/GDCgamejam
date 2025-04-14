extends Node3D
@export var mirrored : bool = false
@export var reload : bool = false
@export var stul : bool = false
@export var origBody: RigidBody3D

const LOADING_SCREEN = preload("res://Scenes/Menu/loading_screen.tscn")
@export_file("*.tscn") var main_menu_scene : String


func shar(body: Node3D) -> void:
	if body is RigidBody3D:
		print(body.pushed)
		if body.pushed:
			death()

func death():
	if(reload):
		get_tree().reload_current_scene()		
	else:
		var loading_scene = LOADING_SCREEN.instantiate()
		loading_scene.next_scene = main_menu_scene
		add_child(loading_scene)
		
		#
		#
		#get_tree().change_scene_to_file(main_menu_scene)
