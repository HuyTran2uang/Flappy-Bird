extends Node

class_name ScoreManager

@onready var score_text = $"../ScoreText" as ScoreText
var score = 0;

func on_game_started():
	score = 0
	score_text.set_score_text(score)

func on_get_scored():
	score += 1
	score_text.set_score_text(score)
