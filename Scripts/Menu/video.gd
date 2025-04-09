extends MarginContainer


@onready var vsyncButton : CheckButton = $VBoxContainer/Vsync/VsyncButton


func _on_vsync_button_toggled(toggled_on: bool) -> void:
	var vsync_enabled = ProjectSettings.get_setting("display/window/vsync/use_vsync")
	ProjectSettings.set_setting("display/window/vsync/use_vsync", !vsync_enabled)
	ProjectSettings.save()
	print("VSync is now: ", !vsync_enabled)
