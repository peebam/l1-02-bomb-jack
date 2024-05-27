class_name StateMachine extends State

signal state_changed(state)
signal state_changed_recursive(state)

var current_state: Node = null :
	set = set_state,
	get = get_state

var previous_state: Node = null :
	get = get_previous_state


func _ready() -> void:
	state_changed.connect(_on_State_state_changed)

	if state_machine is StateMachine:
		state_changed_recursive.connect(_on_State_state_changed_recursive)

	set_default_state()


func _process(delta: float) -> void:
	if current_state != null:
		current_state.update(delta)


func _physics_process(delta: float) -> void:
	if current_state != null:
		current_state.update_physics(delta)

# Override

func enter_state() -> void:
	set_default_state()


func exit_state() -> void:
	clear_state()

# Public

func clear_state() -> void:
	set_state(null)


func get_previous_state() -> Node:
	return previous_state


func get_state() -> Node:
	return current_state


func get_state_name() -> String:
	return current_state.name


func is_previous_state_name(name: String) -> bool:
	return previous_state != null && previous_state.name == name


func is_state_name(name: String) -> bool:
	return current_state != null && current_state.name == name


func is_state_names(names: Array[String]) -> bool:
	return current_state != null && current_state.name in names


func set_default_state() -> void:
	set_state(get_child(0))


func set_state(state) -> void:
	if state is String:
		state = get_node_or_null(state)

	if state == current_state:
		return

	if current_state != null:
		current_state.exit_state()

	previous_state = current_state
	current_state = state

	if current_state != null:
		current_state.enter_state()
		state_changed.emit(current_state)


# Signal

func _on_State_state_changed(_state: State) -> void:
	state_changed_recursive.emit(current_state)


func _on_State_state_changed_recursive(_state: State) -> void:
	state_changed_recursive.emit(current_state)
