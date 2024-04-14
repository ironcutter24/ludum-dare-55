class_name PlayerController
extends CharacterBody2D


const SPEED = 50.0

var direction : Vector2
var looking_right = true

@export var isEnabled = true;

@onready var anim : AnimatedSprite2D = $AnimatedWitch



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
	if isEnabled:
		direction.x = Input.get_axis("move_left", "move_right")
		direction.y = Input.get_axis("move_up", "move_down")
		
		if direction.length() > 0:
			velocity = direction * SPEED
			
			if direction.x != 0.0:
				looking_right = direction.x > 0
			
			anim.play("walk")
		else:
			velocity = Vector2.ZERO  #velocity.lerp(Vector2.ZERO, 4 * delta)
			anim.play("idle")
		
		anim.scale.x = 1 if looking_right else -1

		move_and_slide()
