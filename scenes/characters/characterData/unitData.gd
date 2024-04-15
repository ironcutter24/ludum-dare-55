extends Resource
class_name UnitData


@export var uniqueName: String  # "var uniqueName: String" is all you need to know
@export var spriteFrames: SpriteFrames;
@export var drops: Array[ResourceWithCount]
@export var health = 20;
@export var speed: float;
@export var isSwingingAttack: bool = false;
@export var attackRecoil: float = 1.0;
@export var bulletDirectionVariation := 0.0;
@export var numberOfBullets := 1;

@export_group("Projectiles")
@export var projectileTextures: Array[AtlasTexture]
@export var projectileDamage = 10;
@export var projectileSpeed: float = 50;
@export var projectileAliveTime = 1.0;
@export var bulletsPierce = false;
