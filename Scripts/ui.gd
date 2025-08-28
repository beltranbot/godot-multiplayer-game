extends Control


func game_finished(winner_index: String) -> void:
	$GameFinished.show()
	$GameFinished/WinnerLabel.text = "Player " + winner_index + " Wins!"
	# pause the game
	get_tree().paused = true


func _on_play_again_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_home_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
