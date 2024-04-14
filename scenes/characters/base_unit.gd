class_name BaseUnit
extends CharacterBody2D

@export var Speed: int = 50
@export var Health: int = 100
@export var unitData: UnitData;
@export var projectilePrefab: PackedScene;


var direction : Vector2
var is_flipped = false
var recoilTimer = 0.0;

@onready var targetPosition: Vector2 = global_position
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D


func _ready():
	anim.sprite_frames = unitData.spriteFrames

func setTargetPosition(pos: Vector2):
	targetPosition = pos;
	
func TryAttack():
	if (recoilTimer <= 0):
		_attack();
		
func _attack():

	if (unitData.projectileTexture != null):
		var inst = projectilePrefab.instantiate() as BaseProjectile;
		var projectileDirection = (targetPosition - global_position).normalized();
		inst.normalizedDirection = projectileDirection;
		inst.unitData = unitData;
		inst.refresh();
		get_parent().add_child(inst);
		inst.global_position = global_position;	

	recoilTimer = unitData.attackRecoil;

func setMoveDirection(dir: Vector2):
	direction = dir;

func _physics_process(_delta):
	recoilTimer -= _delta;
	if direction.length() > 0:
		velocity = direction * unitData.speed;
		
		if direction.x != 0.0:
			is_flipped = direction.x < 0
		
		anim.play("walk")
	else:
		velocity = Vector2.ZERO
		anim.play("default")
	
	anim.flip_h = is_flipped

	move_and_slide()
