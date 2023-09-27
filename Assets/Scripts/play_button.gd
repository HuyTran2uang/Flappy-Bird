extends Button

class_name PlayButton

@onready var game_manager = $"../GameManager" as GameManager

func _pressed():
	hide()
	game_manager.on_game_started()
