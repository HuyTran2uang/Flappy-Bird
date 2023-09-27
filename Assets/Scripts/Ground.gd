extends Area2D

class_name Ground

@onready var game_manager = $"../GameManager" as GameManager
@onready var ground_1 = $Ground1 as Sprite2D
@onready var ground_2 = $Ground2 as Sprite2D
signal ground_physics_process(delta)
var speed = 100
var is_started = true

func Speed(): return speed * game_manager.game_speed

func on_game_started():
	is_started = true
	pass

func physics_process(delta):
	if !is_started: return
	ground_1.position.x -= Speed() * delta
	ground_2.position.x -= Speed() * delta
	if ground_1.position.x < -ground_1.texture.get_width():
		ground_1.position.x = ground_2.position.x + ground_2.texture.get_width()
	if ground_2.position.x < -ground_2.texture.get_width():
		ground_2.position.x = ground_1.position.x + ground_1.texture.get_width()

func stop():
	is_started = false
	pass

func _on_body_entered(body):
	if body is Bird:
		body.on_die()
