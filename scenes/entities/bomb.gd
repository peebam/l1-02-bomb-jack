class_name Bomb extends Area2D

var _triggered := false

# Public

func trigger()-> void:
	$AnimatedSprite2D.play("triggered")
	_triggered = true

# Signals

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		$AnimationPlayer.play("collected")
		await $AnimationPlayer.animation_finished

		get_parent().remove_child(self)
		Events.bomb_collected.emit(_triggered)
		queue_free()
