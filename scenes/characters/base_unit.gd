class_name BaseUnit
extends CharacterBody2D


@export var unitData: UnitData;
@export var projectilePrefab: PackedScene;
@export var resourcePrefab: PackedScene;

@export var speed_multiplier: float = 1.0

var direction : Vector2
var is_flipped = false
var recoilTimer = 0.0;

@onready var targetPosition: Vector2 = global_position
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@export var healthBar: ProgressBar


func _ready():
	setUnitData(unitData)
	
func setUnitData(_unitData: UnitData):
	unitData = _unitData
	healthBar.max_value = unitData.health
	healthBar.value = unitData.health
	anim.sprite_frames = unitData.spriteFrames

func setTargetPosition(pos: Vector2):
	targetPosition = pos;
	
func TryAttack():
	if (recoilTimer <= 0):
		_attack();
		
func _attack():
	if (unitData.projectileTextures.size() > 0):
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

func apply_damage(value: int):
	healthBar.value = max(0, healthBar.value - value)
	if (healthBar.value <= 0):
		if get_parent() is PlayerController:
			Global.load_hut_scene();
		else:
			InstantiateDrops();
		get_parent().queue_free();

func InstantiateDrops():
	for resource: ResourceWithCount in unitData.prices:
		for i in range(resource.count):
			if randf() < 0.1:
				var resourceSpawnDist = 10;
				var instantiatedResource: BaseResource = resourcePrefab.instantiate();
				instantiatedResource.resourceData = resource.resourceData;
				get_parent().get_parent().add_child(instantiatedResource);
				instantiatedResource.global_position = global_position + Vector2(randi_range(-resourceSpawnDist, resourceSpawnDist), randi_range(-resourceSpawnDist, resourceSpawnDist));
				instantiatedResource.Refresh();

func _physics_process(_delta):
	z_index = roundi(global_position.y);
	recoilTimer -= _delta;
	if direction.length() > 0:
		velocity = direction * unitData.speed * speed_multiplier;
		
		if direction.x != 0.0:
			is_flipped = direction.x < 0
		
		anim.play("walk")
	else:
		velocity = Vector2.ZERO
		anim.play("default")
	
	anim.flip_h = is_flipped

	move_and_slide()
