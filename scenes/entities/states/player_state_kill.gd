extends "res://scenes/entities/states/player_state_air.gd"

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"


func enter_state() -> void:
	player.velocity = Vector2.ZERO
	animation_player.play("kill")
	await animation_player.animation_finished
	player.queue_free()

