class_name BaseUnit
extends CharacterBody2D

@export var Speed: int = 50
@export var Health: int = 100
@export var MaxHealth: int = 100
@export var unitData: UnitData;
@export var sprite: Sprite2D;

var direction : Vector2
var looking_right = true

func _ready():
	sprite.texture = unitData.texture;

func setTargetPosition(pos: Vector2):
	pass
	
func TryAttack():
	pass;

func setMoveDirection(dir: Vector2):
	direction = dir;

func _physics_process(_delta):
	
	if direction.length() > 0:
		velocity = direction * unitData.speed;
		
		if direction.x != 0.0:
			looking_right = direction.x > 0
		
		# anim.play("walk")
	else:
		velocity = Vector2.ZERO  #velocity.lerp(Vector2.ZERO, 4 * delta)
		# anim.play("idle")
	
	sprite.scale.x = 1 if looking_right else -1

	move_and_slide()
