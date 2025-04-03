extends Label
func _physics_process(delta: float) -> void:
	text = "FPS: "+str(Performance.get_monitor(Performance.TIME_FPS))+"\nDc: "+str(Performance.get_monitor(Performance.RENDER_TOTAL_DRAW_CALLS_IN_FRAME))
