class_name Game extends Node2D

signal run_failed()
signal run_won()

var _level_1_scene: PackedScene = load("res://scenes/levels/level_01.tscn")
var _player_scene: PackedScene = load("res://scenes/entities/player.tscn")

var _is_running := false
var _level : Level
var _player : Player
var _nb_lives : int :
	set = _set_nb_lives
var _score : int :
	set = _set_score
var _streak := 0

func _ready() -> void:
	Events.bomb_collected.connect(_on_Events_bomb_collected)

# Private

func new_run() -> void:
	if _is_running:
		return

	_is_running = true
	_nb_lives = 2

	_level = _level_1_scene.instantiate()
	add_child(_level)
	_level.last_bomb_collected.connect(_on_level_last_bomb_collected)

	_add_player()


func stop_run() -> void:
	if not _is_running:
		return

	_is_running = false

	_level.last_bomb_collected.disconnect(_on_level_last_bomb_collected)
	remove_child(_level)
	_level = null

	remove_child(_player)
	_player = null

# Private

func _add_player() -> void:
	_player = _player_scene.instantiate()
	_player.position = _level.player_init_position
	_player.killed.connect(_on_player_killed)
	add_child(_player)
	Events.player_spawned.emit(_player)


func _set_nb_lives(value: int) -> void:
	_nb_lives = value
	Events.nb_lives_changed.emit(value)


func _set_score(value: int) -> void:
	_score = value
	Events.score_changed.emit(value)

# Signals

func _on_Events_bomb_collected(triggered: bool) -> void:
	if triggered:
		_streak += 100
		_score += _streak
		return

	_streak = 0
	_score += 50


func _on_Events_enemy_spawned(enemy: Enemy) -> void:
	enemy.target = _player


func _on_level_last_bomb_collected() -> void:
	run_won.emit()


func _on_player_killed() -> void:
	$PlayerRespawnTimer.start(1)


func _on_player_respawn_timer_timeout() -> void:
	if _is_running:
		if _nb_lives > 0:
			_nb_lives -= 1
			_add_player()
		else:
			run_failed.emit()
