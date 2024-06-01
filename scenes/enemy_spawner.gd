extends Node2D

@export_range (1, 20) var delay: int
@export_range (1, 10) var nb_enemies: int

var _enemies_target: Node2D :
	set = _set_enemies_target

var _count_enemies := 0
var _enemy_scene: PackedScene = load("res://scenes/entities/enemy.tscn")

func _ready() -> void:
	Events.player_spawned.connect(_on_Events_player_spawned)
	$Timer.start(delay)

# Private

func _set_enemies_target(target: Node2D) -> void:
	_enemies_target = target
	for enemy in $Enemies.get_children():
		enemy.target = _enemies_target

# Signals

func _on_timer_timeout() -> void:
	var enemy: Enemy = _enemy_scene.instantiate()
	enemy.target = _enemies_target
	$Enemies.add_child(enemy)

	_count_enemies += 1
	if _count_enemies < nb_enemies:
		$Timer.start(delay)


func _on_Events_player_spawned(player: Player) -> void:
	_enemies_target = player
