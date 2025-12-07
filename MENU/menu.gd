extends CanvasLayer


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://MAIN/main.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_tutorial_pressed() -> void:
	get_tree().change_scene_to_file("res://TUTORIAL/tutorial.tscn")
