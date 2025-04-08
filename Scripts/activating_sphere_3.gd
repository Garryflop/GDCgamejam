extends RigidBody3D
var looking : bool = false
const LOADING_SCREEN = preload("res://Scenes/Levels/level2.tscn")
@export_file("*.tscn") var next_scene : String

func _physics_process(delta: float) -> void:
	if(looking && (global_position.z>60.1 || global_position.z < 3.3)):
		get_tree().change_scene(next_scene)
		
		
		#var loading_scene = LOADING_SCREEN.instantiate()
		#loading_scene.next_scene = next_scene
		#add_child(loading_scene)
		#pass
