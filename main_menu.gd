extends Control
var game = preload("res://main_scene.tscn")

func _ready() -> void:
	pass
	

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(game)


func _on_quit_button_pressed() -> void:
	get_tree().quit()
