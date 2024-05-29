extends PlayerState

signal direction_changed()

var _direction := 0

# Public

func enter_state() -> void:
	_direction = sign(player.velocity.x)
	_switch_animation()
	player.animated_sprite.play("idle")


func update(delta: float) -> void:
	if not player.is_on_floor():
		state_machine.set_state("Air")

	var direction := Input.get_axis("gm_left", "gm_right")
	player.move(delta, direction)
	player.move_and_slide()

	if sign(player.velocity.x) != _direction:
		_direction = sign(player.velocity.x)
		direction_changed.emit()

	if direction == 0 and player.velocity.x == 0:
		state_machine.set_state("Idle")

	var jump := Input.is_action_just_pressed("gm_jump")
	if jump:
		state_machine.set_state("Jump")


func _switch_animation() -> void:
	if _direction == 1:
		player.animated_sprite.play("run_right")
	else:
		player.animated_sprite.play("run_left")

# Signals

func _on_direction_changed() -> void:
	_switch_animation()
