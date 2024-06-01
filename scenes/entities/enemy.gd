class_name Enemy extends CharacterBody2D

@export var target: Node2D
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var _direction := 0
var _following_enabled := false
var _speed := randf_range(30, 60)
var _target_position := Vector2.ZERO

func _physics_process(delta: float) -> void:
	_flollow()

	if _following_enabled:
		var next_position = navigation_agent.get_next_path_position()
		var direction = global_position.direction_to(next_position).normalized()

		velocity =  direction * _speed
		navigation_agent.set_velocity(velocity * delta)
		move_and_slide()

	_set_animation()

# Private

func _flollow() -> void:
	if target == null:
		_following_enabled = false
		return

	if _target_position != target.global_position:
		_target_position = target.global_position
		_following_enabled = true
		navigation_agent.target_position = target.global_position


func _set_animation() -> void:
	if _direction != sign(velocity.x):
		_direction = sign(velocity.x)
		if _direction == -1:
			animated_sprite.play("fly_left")
		else:
			animated_sprite.play("fly_right")

# Signals

func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity
	move_and_slide()


func _on_player_detector_body_entered(body: Node2D) -> void:
	if body is Player:
		body.kill()


