class_name Level extends Node2D

signal last_bomb_collected()

@export var player_init_position := Vector2.ZERO

func _ready() -> void:
	_trigger_bomb()
	Events.bomb_collected.connect(_on_Events_bomb_collected)

# Public

func _trigger_bomb() -> void:
	var count = $Bombs.get_child_count()
	if count == 0:
		last_bomb_collected.emit()
		return

	var bomb: Bomb = $Bombs.get_child(0)
	bomb.trigger()

# Signals

func _on_Events_bomb_collected(triggered: bool) -> void:
	if triggered:
		_trigger_bomb()
