class_name State extends Node

@onready var state_machine = get_parent()

# Public

func enter_state() -> void:
	pass


func exit_state() -> void:
	pass


func is_current_state() -> bool:
	return state_machine.is_state_name(name)


func update(_delta: float) -> void:
	pass


func update_physics(_delta: float) -> void:
	pass
