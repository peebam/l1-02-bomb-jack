class_name StateLabel extends Label

@export var state_machine: StateMachine

func _ready() -> void:
	assert(state_machine != null)
	state_machine.state_changed_recursive.connect(_on_state_machine_state_changed_recursive)

# Public

func get_state_name(state: State) -> String:
	if state == null:
		return ""

	if state is StateMachine:
		return state.name + "/" + get_state_name(state.get_state())
	else:
		return state.name

# Private

func _update_text(state: State) -> void:
	var text = get_state_name(state)
	set_text(text)

# Signals

func _on_state_machine_state_changed_recursive(state: Node) -> void:
	_update_text(state)
