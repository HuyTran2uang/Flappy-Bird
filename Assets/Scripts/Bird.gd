extends CharacterBody2D

class_name Bird

@onready var game_manager = $"../GameManager" as GameManager
@onready var animation_player = $AnimationPlayer
var gravity = 900.0 
var jump_force = -250
var rotation_speed = 2
var max_speed = 400
var is_started = false

func Gravity(): return gravity
func Jump_force(): return jump_force
func Rotation_speed(): return rotation_speed
func Max_speed(): return max_speed

func _ready():
	idle()

func on_game_started():
	idle()
	position = Vector2.ZERO
	rotation = 0
	is_started = true
	jump()

func physics_process(delta):
	if !is_started: return
	if Input.is_action_pressed("jump"): jump()
	on_gravity(delta)
	move_and_collide(velocity * delta)
	rotate_bird()

func idle():
	velocity = Vector2.ZERO
	animation_player.play("Idle")

func jump():
	velocity.y = Jump_force()
	rotation = deg_to_rad(-30)
	animation_player.play("Fly")

func on_gravity(delta):
	velocity.y += Gravity() * delta
	velocity.y = min(velocity.y, Max_speed())

func rotate_bird():
	# Rotate downwards when falling
	if velocity.y > 0 && rad_to_deg(rotation) < 90:
		rotation += Rotation_speed() * deg_to_rad(1)
	# Rotate upwards when rising
	elif velocity.y < 0 && rad_to_deg(rotation) > -30:
		rotation -= Rotation_speed() * deg_to_rad(1)

func on_die():
	velocity = Vector2.ZERO
	animation_player.stop()
	is_started = false
	game_manager.on_end_game()
	
func on_get_scored():
	game_manager.on_get_scored()
