extends CanvasLayer

@onready var messages_label: RichTextLabel = $Control/ColorRect/MarginContainer/VBoxContainer/ScrollContainer/RichTextLabel
@onready var sound_player: AudioStreamPlayer = $AudioStreamPlayer

var message_queue: Array = []
var is_displaying: bool = false
var is_hidden: bool = false

func show_console() -> void:
	is_hidden = false
	$AnimationPlayer.play("appear")

func hide_console() -> void:
	is_hidden = true
	$AnimationPlayer.play("disappear")

func start(dialog_file_path: String) -> void:
	if is_displaying:
		load_dialog_data(dialog_file_path)
	else:
		clear_messages()
		show_console()
		load_dialog_data(dialog_file_path)

func _ready() -> void:
	$AnimationPlayer.play("RESET")
	pass

func load_dialog_data(dialog_file_path: String) -> void:
	if FileAccess.file_exists(dialog_file_path):
		var file = FileAccess.open(dialog_file_path, FileAccess.READ)
		while not file.eof_reached():
			var line: String = file.get_line().strip_edges()
			if line == "":
				continue
			var parts: Array = line.split("|")
			if parts.size() >= 2:
				var speaker: String = parts[0].strip_edges()
				var text: String = parts[1].strip_edges()
				queue_message(speaker, text)
		file.close()
	else:
		push_error("Файл с диалогами не найден: " + dialog_file_path)

func queue_message(speaker: String, text: String) -> void:
	message_queue.append([speaker, text])
	if not is_displaying:
		process_messages()

func process_messages() -> void:
	is_displaying = true
	while not message_queue.is_empty():
		var message = message_queue.pop_front()
		add_message(message[0], message[1])
		await get_tree().create_timer(3).timeout
	await get_tree().create_timer(0.6).timeout
	is_displaying = false

func add_message(speaker: String, text: String) -> void:
	messages_label.text += "[color=#00FF00][b]" + speaker + ":[/b] " + text + "\n[/color]"
	messages_label.scroll_to_line(messages_label.get_line_count() - 1)
	play_sound_effect()

func play_sound_effect() -> void:
	if sound_player:
		sound_player.play()

func clear_messages() -> void:
	messages_label.text = ""
	message_queue.clear()


func _on_back_button_pressed() -> void:
	if !is_hidden:
		hide_console()
	else:
		show_console()
