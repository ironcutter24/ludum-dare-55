class_name BaseUnit
extends CharacterBody2D

@export var Speed: int = 50
@export var Health: int = 100
@export var unitData: UnitData;
@export var sprite: Sprite2D;
@export var projectilePrefab: PackedScene;


var direction : Vector2
var looking_right = true
var recoilTimer = 0.0;
@onready var targetPosition: Vector2 = global_position;

func _ready():
	sprite.texture = unitData.texture;

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
			looking_right = direction.x > 0
		
		# anim.play("walk")
	else:
		velocity = Vector2.ZERO  #velocity.lerp(Vector2.ZERO, 4 * delta)
		# anim.play("idle")
	
	sprite.scale.x = 1 if looking_right else -1

	move_and_slide()
