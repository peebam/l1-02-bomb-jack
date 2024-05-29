extends PlayerState

signal direction_changed()

var _direction := 0
var _air_time := 0.0

# Public

func enter_state() -> void:
	_direction = sign(player.velocity.x)
	_switch_animation()
	_air_time = 0.0


func update(delta: float) -> void:
	if player.is_on_floor():
		if player.velocity.x == 0:
			state_machine.set_state("Idle")
		else:
			state_machine.set_state("Run")

	var jump := Input.is_action_just_pressed("gm_jump")
	if jump and _air_time <= 0.1 and state_machine.is_previous_state_name("Run"):
		state_machine.set_state("Jump")

	var direction := Input.get_axis("gm_left", "gm_right")
	player.move(delta, direction)
	player.air(delta)
	player.move_and_slide()

	if sign(player.velocity.x) != _direction:
		_direction = sign(player.velocity.x)
		direction_changed.emit()

	_air_time += delta


func _switch_animation() -> void:
	if _direction == 0:
		player.animated_sprite.play("jump")
	elif _direction == 1:
		player.animated_sprite.play("jump_right")
	else:
		player.animated_sprite.play("jump_left")

# Signals

func _on_direction_changed() -> void:
	_switch_animation()
