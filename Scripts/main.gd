extends Node

var scores: Array[int] = [0, 0]
var current_round: int = 1


func scored(death_player_index: int) -> void:
	scores[death_player_index - 1] += 1

	if death_player_index == 1:
		get_node("UI/Container/Player2/ScoreLabel").text = self.get_score_as_text(death_player_index)
	if death_player_index == 2:
		get_node("UI/Container/Player1/ScoreLabel").text = self.get_score_as_text(death_player_index)

	var winner_index: int

	if death_player_index == 1:
		winner_index = 2
	if death_player_index == 2:
		winner_index = 1

	if global.current_game_mode == global.game_modes.SingleMatch:
		$UI.game_finished(str(winner_index))

	if global.current_game_mode == global.game_modes.Championship and (current_round == 2 and scores.has(2)):
		$UI.game_finished(str(winner_index))

	current_round += 1


func get_score_as_text(player_index: int) -> String:
	return str(scores[player_index - 1])
