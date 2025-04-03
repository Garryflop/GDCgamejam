extends CanvasLayer

const LOADING_SCREEN = preload("res://Scenes/Menu/loading_screen.tscn")

@export var options_packed_scene : PackedScene
@export_file("*.tscn") var main_menu_scene : String
#@export var pause_menu_packed : PackedScene
#func _on_button_button_up() -> void:
	#var current_menu = pause_menu_packed.instantiate()
	#get_tree().current_scene.call_deferred("add_child", current_menu)
	#get_tree().paused = true

func _ready() -> void:
	_setup_options()
	_setup_main_menu()


func _setup_options() -> void:
	if options_packed_scene == null:
		%OptionsButton.hide()

func _setup_main_menu() -> void:
	if main_menu_scene.is_empty():
		%MainMenuButton.hide()

func open_options_menu():
	var options_scene = options_packed_scene.instantiate()
	add_child(options_scene)

func _on_resume_button_pressed() -> void:
	get_tree().paused = false
	queue_free()

func _on_options_button_button_up() -> void:
	open_options_menu()


func _on_main_menu_button_button_up() -> void:
	get_tree().paused = false
	var loading_scene = LOADING_SCREEN.instantiate()
	loading_scene.next_scene = main_menu_scene
	add_child(loading_scene)


func _on_quit_button_button_up() -> void:
	get_tree().free()
