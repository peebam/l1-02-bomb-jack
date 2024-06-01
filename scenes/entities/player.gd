class_name Player extends CharacterBody2D

signal killed()

const JUMP_SPEED := 200.0
const MOVE_SPEED = 100.0

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("born")

# Public

func air(delta: float) -> void:
	velocity.y += gravity * delta


func kill() -> void:
	if $InvicibleTimer.is_stopped():
		$MovementStateMachine.set_state("Kill")


func jump() -> void:
	velocity.y = -JUMP_SPEED


func move(direction: float) -> void:
	if direction != 0:
		velocity.x = MOVE_SPEED * direction
	else:
		velocity.x = 0

# Signals

func _on_tree_exited() -> void:
	killed.emit()

