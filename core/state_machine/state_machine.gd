class_name StateMachine extends State

signal state_changed(state)
signal state_changed_recursive(state)

var _current_state: Node = null :
	set = set_state,
	get = get_state

var _previous_state: Node = null


func _ready() -> void:
	state_changed.connect(_on_State_state_changed)

	if state_machine is StateMachine:
		state_changed_recursive.connect(_on_State_state_changed_recursive)

	set_default_state.call_deferred()


func _process(delta: float) -> void:
	if _current_state != null:
		_current_state.update(delta)


func _physics_process(delta: float) -> void:
	if _current_state != null:
		_current_state.update_physics(delta)

# Override

func enter_state() -> void:
	set_default_state()


func exit_state() -> void:
	clear_state()

# Public

func clear_state() -> void:
	set_state(null)


func get_state() -> Node:
	return _current_state


func is_previous_state_name(state) -> bool:
	if state is String:
		return _previous_state != null && _previous_state.name == state

	if state is State:
		return _previous_state != null && _previous_state.name == state.name

	return false


func is_state(state) -> bool:
	if state is String:
		return _current_state != null && _current_state.name == state

	if state is State:
		return _current_state != null && _current_state.name == state.name

	return false


func set_default_state() -> void:
	set_state(get_child(0))


func set_state(state) -> void:
	if state is String:
		state = get_node_or_null(state)

	if state == _current_state:
		return

	if _current_state != null:
		_current_state.exit_state()

	_previous_state = _current_state
	_current_state = state

	if _current_state != null:
		_current_state.enter_state()
		state_changed.emit(_current_state)

# Signal

func _on_State_state_changed(_state: State) -> void:
	state_changed_recursive.emit(_current_state)


func _on_State_state_changed_recursive(_state: State) -> void:
	state_changed_recursive.emit(_current_state)
