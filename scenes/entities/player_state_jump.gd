extends PlayerState

signal direction_changed()

var _direction := 0
var _jump_time := 0.0

# Public

func enter_state() -> void:
	_direction = sign(player.velocity.x)
	_switch_animation()
	_jump_time = 0.0


func update(delta: float) -> void:
	if player.is_on_ceiling():
		state_machine.set_state("Air")

	if _jump_time >= player.JUMP_TIME:
		state_machine.set_state("Air")

	var direction := Input.get_axis("gm_left", "gm_right")
	player.move(delta, direction)
	player.jump(delta)
	player.move_and_slide()

	if sign(player.velocity.x) != _direction:
		_direction = sign(player.velocity.x)
		direction_changed.emit()

	_jump_time += delta


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

