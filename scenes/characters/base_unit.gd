class_name BaseUnit
extends CharacterBody2D

@export var Speed: int = 50
@export var Health: int = 100
@export var unitData: UnitData;
@export var projectilePrefab: PackedScene;
@export var resourcePrefab: PackedScene;


var direction : Vector2
var is_flipped = false
var recoilTimer = 0.0;

@onready var targetPosition: Vector2 = global_position
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@export var healthBar: ProgressBar


func _ready():
	# The max value is the initial amount of health the creature has
	healthBar.max_value = unitData.health 
	anim.sprite_frames = unitData.spriteFrames
	
func setUnitData(_unitData: UnitData):
	unitData = _unitData
	Health = unitData.health;
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
		inst.isPlayerBullet = !(get_parent() is BaseEnemy)

	recoilTimer = unitData.attackRecoil;

func setMoveDirection(dir: Vector2):
	direction = dir;
	
func _process(delta):
	healthBar.value = Health / unitData.health;
	
	if (Health < 0.0):
		if get_parent() is PlayerController:
			Global.load_hut_scene();
		else:
			InstantiateDrops();
		get_parent().queue_free();

func InstantiateDrops():
	for resource: ResourceWithCount in unitData.prices:
		for i in range(resource.count):
			if randf() < 0.05:
				var instantiatedResource: BaseResource = resourcePrefab.instantiate();
				instantiatedResource.resourceData = resource.resourceData;
				
		

func _physics_process(_delta):
	z_index = global_position.y;
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
