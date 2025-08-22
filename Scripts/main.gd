extends Node

var scores: Array[int] = [0, 0]


func scored(death_player_index: int) -> void:
	scores[death_player_index - 1] += 1

	if death_player_index == 1:
		get_node("UI/Container/Player2/ScoreLabel").text = self.get_score_as_text(death_player_index)
	if death_player_index == 2:
		get_node("UI/Container/Player1/ScoreLabel").text = self.get_score_as_text(death_player_index)


func get_score_as_text(player_index: int) -> String:
	return str(scores[player_index - 1])
