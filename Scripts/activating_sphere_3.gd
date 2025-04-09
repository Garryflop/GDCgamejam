extends RigidBody3D
var looking : bool = false
const LOADING_SCREEN = preload("res://Scenes/Menu/loading_screen.tscn")
@export_file("*.tscn") var main_menu_scene : String
var is_activated : bool = false

func _physics_process(delta: float) -> void:
	if(looking && (global_position.z>60.1 || global_position.z < 3.3)) && !is_activated:
		is_activated = true
		var loading_scene = LOADING_SCREEN.instantiate()
		loading_scene.next_scene = main_menu_scene
		add_child(loading_scene)
		
		#
		#
		#get_tree().change_scene_to_file(main_menu_scene)
