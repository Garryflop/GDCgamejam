extends Control

@onready var progress_bar: ProgressBar = $ProgressBar
var next_scene: String = ""
var last_progress = 0.0

func _ready() -> void:
	ResourceLoader.load_threaded_request(next_scene, "")


func _process(delta: float) -> void:
	var progress = []
	var loaded_status = ResourceLoader.load_threaded_get_status(next_scene, progress)
	var new_progress = progress[0] * 100.0
	last_progress = max(last_progress, new_progress)
	progress_bar.value = lerp(progress_bar.value, last_progress, delta * 5.5)
	
	if loaded_status == ResourceLoader.ThreadLoadStatus.THREAD_LOAD_LOADED:
		progress_bar.value = 100.0
		var packed_next_scene = ResourceLoader.load_threaded_get(next_scene)
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_packed(packed_next_scene)
