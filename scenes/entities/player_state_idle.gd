extends PlayerState

# Public

func enter_state() -> void:
	player.animated_sprite.play("idle")


func exit_state() -> void:
	pass


func update_physics(_delta: float) -> void:
	if not player.is_on_floor():
		state_machine.set_state("Air")

	var direction := Input.get_axis("gm_left", "gm_right")
	if direction != 0:
		state_machine.set_state("Run")

	var jump := Input.is_action_just_pressed("gm_jump")
	if jump:
		state_machine.set_state("Jump")
