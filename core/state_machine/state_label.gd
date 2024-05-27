class_name StateLabel extends Label

func _ready() -> void:

	await get_parent().ready

	get_parent().state_changed_recursive.connect(_on_StateMachine_state_changed_recursive)
	_update_text(get_parent().current_state)

# Public

func get_state_name(state: State) -> String:
	if state is StateMachine:
		return state.name + "/" + get_state_name(state.get_state())
	else:
		return state.name

# Private

func _update_text(state: State) -> void:
	var text = get_state_name(state)
	set_text(text)

# Signals

func _on_StateMachine_state_changed_recursive(state: Node) -> void:
	_update_text(state)
