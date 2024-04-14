class_name PlayerController
extends CharacterBody2D


const SPEED = 10.0

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

func _physics_process(delta):
	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")
	
	
	velocity += direction * SPEED
	velocity = velocity.lerp(Vector2.ZERO, 4 * delta)
	
	$AnimatedWitch.scale.x = 1 if velocity.x >= 0 else -1
	print(velocity.x)

	move_and_slide()
