extends Node

class_name PipeSpawner

@onready var game_manager = $"../GameManager" as GameManager
var pipe_pair_prefab = preload("res://Assets/Nodes/pipe_pair.tscn")
var pipe_pairs = []
var count_pipe_pair = 3
var is_started = false
var screne_width = 288
var space_smooth_spawn = 50
var space_between_pipes = 200
var position_x_out_range_scene = -200
var speed = 100

func Speed(): return speed * game_manager.game_speed

func on_game_started():
	spawn_pipe_pair()
	is_started = true

func spawn_pipe_pair():
	if !pipe_pairs.is_empty():
		for i in range(3):
			(pipe_pairs[i] as PipePair).set_position_x(screne_width / 2.0 + space_smooth_spawn + i * space_between_pipes)
		return
		
	for i in range(count_pipe_pair):
		var pipe_pair = pipe_pair_prefab.instantiate()
		add_child(pipe_pair)
		pipe_pairs.append(pipe_pair)
		(pipe_pair as PipePair).set_position_x(screne_width / 2.0 + space_smooth_spawn + i * space_between_pipes)

func physics_process(delta):
	if !is_started: return
	for i in range(count_pipe_pair):
		(pipe_pairs[i] as PipePair).move(Speed() * delta)
	pipe_pair_loop_move()

func pipe_pair_loop_move():
	if (pipe_pairs[0] as PipePair).get_position_x() < position_x_out_range_scene:
		(pipe_pairs[0] as PipePair).set_position_x((pipe_pairs[2] as PipePair).get_position_x() + space_between_pipes)
	if (pipe_pairs[1] as PipePair).get_position_x() < position_x_out_range_scene:
		(pipe_pairs[1] as PipePair).set_position_x((pipe_pairs[0] as PipePair).get_position_x() + space_between_pipes)
	if (pipe_pairs[2] as PipePair).get_position_x() < position_x_out_range_scene:
		(pipe_pairs[2] as PipePair).set_position_x((pipe_pairs[1] as PipePair).get_position_x() + space_between_pipes)

func stop():
	is_started = false
