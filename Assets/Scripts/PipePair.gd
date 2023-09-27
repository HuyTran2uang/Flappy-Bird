extends Node2D

class_name PipePair


var min_height = -90
var max_height = 70

func _ready():
	random_height()

func random_height():
	position.y = randf_range(min_height, max_height)

func move(speed):
	position.x -= speed

func _on_body_entered(body):
	if body is Bird:
		body.on_die()

func _on_point_scored(body):
	if body is Bird:
		body.on_get_scored()

func set_position_x(x):
	position.x = x
	
func get_position_x():
	return position.x
