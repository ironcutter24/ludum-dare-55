class_name PlayerController
extends Node2D

var direction : Vector2
var looking_right = true

@export var isEnabled = true;
@export var baseUnit: BaseUnit;

#@onready var anim : AnimatedSprite2D = $AnimatedWitch



func _enter_tree():
	Global.player_controller = baseUnit

func _exit_tree():
	Global.player_controller = null


func _input(event):
	# Interaction
	if event.is_action_pressed("attack"):
		baseUnit.TryAttack()

func _physics_process(_delta):
	if isEnabled:
		direction.x = Input.get_axis("move_left", "move_right")
		direction.y = Input.get_axis("move_up", "move_down")
		baseUnit.setMoveDirection(direction);
