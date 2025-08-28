extends Control

@export var player_buttons: Array[Button]

func _ready() -> void:
	for button in player_buttons:
		button.pressed.connect(on_player_button_pressed.bind(
			button,
			button.get_theme_stylebox("normal").bg_color,
			button.get_parent().get_parent().get_node("Label").text.replace("Player ", "")
		))

func on_player_button_pressed(button_pressed: Button, player_color: Color, player_index: String) -> void:
	if player_index == "1":
		global.player_1_color = player_color

		for i in range(3):
			set_borders(player_buttons[i].get_theme_stylebox("normal"), 0)

	if player_index == "2":
		global.player_2_color = player_color

		for i in range(3):
			set_borders(player_buttons[i + 3].get_theme_stylebox("normal"), 0)
	if global.player_1_color != Color.BLACK and global.player_2_color != Color.BLACK:
		$"2/PlayButton".disabled = false

	set_borders(button_pressed.get_theme_stylebox("normal"), 5)


func set_borders(stylebox: StyleBox, border_size: int) -> void:
	stylebox.border_width_left = border_size
	stylebox.border_width_top = border_size
	stylebox.border_width_right = border_size
	stylebox.border_width_bottom = border_size


func _on_initial_buttons_pressed() -> void:
	$"1".hide()
	$"2".show()


func _on_championship_button_pressed() -> void:
	global.current_game_mode = global.game_modes.Championship


func _on_single_match_button_pressed() -> void:
	global.current_game_mode = global.game_modes.SingleMatch


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_come_back_button_pressed() -> void:
	$"2".hide()
	$"1".show()
