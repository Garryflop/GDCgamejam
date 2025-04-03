extends CanvasLayer

const LOADING_SCREEN = preload("res://Scenes/Menu/loading_screen.tscn")
@export_file("*.tscn") var main_menu_scene : String



func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "IN":
		var loading_scene = LOADING_SCREEN.instantiate()
		loading_scene.next_scene = main_menu_scene
		add_child(loading_scene)
