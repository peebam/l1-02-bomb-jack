class_name Player extends CharacterBody2D

const JUMP_ACCELERATION := 980.0
const JUMP_SPEED_MAX := 200.0
const JUMP_TIME = 0.4

const MOVE_SPEED_MAX = 100.0
const MOVE_ACCELERATION := 200.0

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

# Public

func move(delta: float, direction: float) -> void:
	if direction != 0:
		velocity.x = clamp(velocity.x + direction * MOVE_ACCELERATION,
			-MOVE_SPEED_MAX,
			MOVE_SPEED_MAX)
	else:
		velocity.x = 0


func jump(delta: float) -> void:
	velocity.y = -JUMP_SPEED_MAX #clamp(velocity.y - JUMP_ACCELERATION * delta, -JUMP_SPEED_MAX, 0)


func air(delta: float) -> void:
	velocity.y += gravity * delta


func hover(delta: float) -> void:
	velocity.y += gravity * delta

