extends CanvasLayer

const LOADING_SCREEN = preload("res://Scenes/Menu/loading_screen.tscn")

@export_file("*.tscn") var game_scene : String
@export var settings_packed_scene : PackedScene
@export var credits_packed_scene : PackedScene

var settings_scene
var credits_scene
var sub_menu


func _open_sub_menu(menu):
	sub_menu = menu
	if sub_menu != null:
		sub_menu.show()
		%Back.show()
		%MenuCont.hide()
	else:
		print(sub_menu)


func _close_sub_menu():
	if sub_menu == null:
		return
	sub_menu.hide()
	sub_menu = null
	%Back.hide()
	%MenuCont.show()


func _setup_options():
	if settings_packed_scene == null:
		%SettingsCont.hide()
	else:
		settings_scene = settings_packed_scene.instantiate()
		settings_scene.hide()
		%SettingsCont.call_deferred("add_child", settings_scene)


func _setup_credits():
	if credits_packed_scene == null:
		%CreditsCont.hide()
	else:
		credits_scene = credits_packed_scene.instantiate()
		credits_scene.hide()
		%CreditsCont.call_deferred("add_child", credits_scene)


func _on_play_button_up():
	var loading_scene = LOADING_SCREEN.instantiate()
	loading_scene.next_scene = game_scene
	add_child(loading_scene)
	pass
	#AudioManager.play_sound($AudioStreamPlayer.stream)
	#AudioManager.change_music("Game")
	#Global.next_scene(game_scene)


func _on_settings_button_up():
	_open_sub_menu(settings_scene)


func _on_credits_button_up():
	_open_sub_menu(credits_scene)


func _on_quit_button_up():
	get_tree().quit()


func _on_back_button_up():
	_close_sub_menu()

func _ready():
	_setup_options()
	_setup_credits()
