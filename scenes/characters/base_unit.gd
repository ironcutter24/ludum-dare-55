class_name BaseUnit
extends CharacterBody2D


const DROPS_AMOUNT_MIN = 2
const DROPS_AMOUNT_MAX = 4

@export var unitData: UnitData;
@export var projectilePrefab: PackedScene;
@export var resourcePrefab: PackedScene;
@export var speed_multiplier: float = 1.0
@export var healthBar: ProgressBar
@export var showHealthBar: bool = true

var direction : Vector2
var is_flipped = false
var recoilTimer = 0.0;

@onready var targetPosition: Vector2 = global_position
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D


func _ready():
	setUnitData(unitData)
	
func setUnitData(_unitData: UnitData):
	unitData = _unitData
	healthBar.max_value = unitData.health
	healthBar.value = unitData.health
	anim.sprite_frames = unitData.spriteFrames
	healthBar.visible = showHealthBar

func setTargetPosition(pos: Vector2):
	targetPosition = pos;

func TryAttack():
	if (recoilTimer <= 0):
		_attack();

func _attack():
	if (unitData.projectileTextures.size() > 0):
		for i in range(unitData.numberOfBullets):
			var randomRotation = (randf()-0.5) * unitData.bulletDirectionVariation * PI/180.0
			var inst = projectilePrefab.instantiate() as BaseProjectile;
			var projectileDirection = (targetPosition - global_position).normalized().rotated(randomRotation);
			inst.normalizedDirection = projectileDirection;
			inst.unitData = unitData;
			inst.refresh();
			get_parent().add_child(inst);
			inst.global_position = global_position + Vector2.UP * 16;
			inst.isPlayerBullet = !(get_parent() is BaseEnemy)
	
	recoilTimer = unitData.attackRecoil;

func setMoveDirection(dir: Vector2):
	direction = dir;

func apply_damage(value: int):
	healthBar.value = max(0, healthBar.value - value)
	if (healthBar.value <= 0):
		if get_parent() is PlayerController:
			StoryProgress.hasDiedOnce = true;
			Global.load_hut_scene();
		else:
			InstantiateDrops();
		get_parent().queue_free();

func InstantiateDrops():
	for resource: ResourceWithCount in unitData.drops:
		var drops_amount = GetDropsAmount()
		for i in range(drops_amount):
			var resourceSpawnDist = 10;
			var instantiatedResource: BaseResource = resourcePrefab.instantiate();
			instantiatedResource.resourceData = resource.resourceData;
			get_parent().get_parent().add_child(instantiatedResource);
			instantiatedResource.global_position = global_position + Vector2(randi_range(-resourceSpawnDist, resourceSpawnDist), randi_range(-resourceSpawnDist, resourceSpawnDist));
			instantiatedResource.Refresh();

func GetDropsAmount():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	return rng.randi_range(DROPS_AMOUNT_MIN, DROPS_AMOUNT_MAX)

func _physics_process(_delta):
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
