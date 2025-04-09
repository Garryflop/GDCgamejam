extends VBoxContainer


@export var MName: String
@export var Mtext: String


func _ready() -> void:
	$Name.text = MName
	$Text.text = Mtext
