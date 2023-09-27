extends Node

class_name GameManager

@onready var bird = $"../Bird" as Bird
@onready var score_manager = $"../ScoreManager" as ScoreManager
@onready var play_button = $"../Play Button"
@onready var ground = $"../Ground" as Ground
@onready var pipe_spawner = $"../PipeSpawner" as PipeSpawner
var game_speed = 1.0
var max_game_speed = 2.0
var is_started = false

func _process(delta):
	if is_started: return
	if Input.is_key_pressed(KEY_SPACE):
		(play_button as PlayButton).hide()
		on_game_started()

func _physics_process(delta):
	bird.physics_process(delta)
	ground.physics_process(delta)
	pipe_spawner.physics_process(delta)

func on_game_started():
	game_speed = 1
	bird.on_game_started()
	score_manager.on_game_started()
	ground.on_game_started()
	pipe_spawner.on_game_started()
	is_started = true

func on_end_game():
	play_button.show()
	ground.stop()
	pipe_spawner.stop()
	await get_tree().create_timer(1).timeout
	completed_game()

func completed_game():
	is_started = false

func on_get_scored():
	score_manager.on_get_scored()
	if score_manager.score % 5 == 0:
		increase_speed()

func increase_speed():
	game_speed += 0.1
	game_speed = min(game_speed, max_game_speed)
