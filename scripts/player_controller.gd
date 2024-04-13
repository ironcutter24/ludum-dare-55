class_name PlayerController
extends CharacterBody2D


const SPEED = 80.0

var direction : Vector2


func _enter_tree():
	Global.player_controller = self

func _exit_tree():
	Global.player_controller = null


func _input(event):
	# Interaction
	if event.is_action_pressed("interact"):
		pass
	
	if event.is_action_pressed("attack"):
		pass

func _physics_process(_delta):
	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")
	
	if direction:
		velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
