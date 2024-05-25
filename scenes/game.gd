class_name Game extends Node2D

signal run_failed()
signal run_won()

# Private

func _new_run() -> void:
	pass


func _stop_run() -> void:
	pass


# Signals

func _on_main_menu_quiited() -> void:
	get_tree().quit()


func _on_main_menu_run_started() -> void:
	_new_run()
	$Ui/MainMenu.visible = false
	$Ui/HUD.visible = true


func _on_run_failed() -> void:
	_stop_run()
	$Ui/HUD.visible = false
	$Ui/RunFailedMenu.visible = true


func _on_run_failed_menu_main_menu() -> void:
	$Ui/MainMenu.visible = true
	$Ui/RunFailedMenu.visible = false


func _on_run_won() -> void:
	_stop_run()
	$Ui/HUD.visible = false
	$Ui/RunWonMenu.visible = true


func _on_run_won_menu_main_menu() -> void:
	$Ui/MainMenu.visible = true
	$Ui/RunWonMenu.visible = false


func _on_hud_run_stopped() -> void:
	_stop_run()
	$Ui/MainMenu.visible = true
	$Ui/HUD.visible = false
