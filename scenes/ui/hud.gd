extends Control

signal run_stopped()

# Signals

func _on_stop_run_button_pressed() -> void:
	run_stopped.emit()
