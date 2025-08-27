extends Control

@export var player_buttons: Array[Button]

func _ready() -> void:
	for button in player_buttons:
		button.pressed.connect(on_player_button_pressed.bind(
			button,
			button.get_theme_stylebox("normal").bg_color,
			button.get_parent().get_node("Label").text.replace("Player ", "")
		))

func on_player_button_pressed(button_pressed: Button, player_color: Color, player_index: String) -> void:
	if player_index == "1":
		global.player_1_color = player_color

	if player_index == "2":
		global.player_2_color = player_color
		

func set_borders(stylebox: StyleBox, border_size: int) -> void:
	stylebox.boder_width_left = border_size
	stylebox.boder_width_top = border_size
	stylebox.boder_width_right = border_size
	stylebox.boder_width_bottom = border_size
