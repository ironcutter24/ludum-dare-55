extends CharacterBody2D


const SPEED = 300.0

var direction : Vector2

func _unhandled_input(event):
	# Interaction
	#if event.is_action_pressed(""):
		#pass
	pass

func _physics_process(_delta):
	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down") * 0.5
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.y = direction.y * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
