extends Resource
class_name UnitData


@export var prices: Array[ResourceWithCount]
@export var uniqueName: String # "var uniqueName: String" is all you need to know
@export var speed: float;
@export var isSwingingAttack: bool = false;
@export var projectileSpeed: float = 50;
var projectileTexture: AtlasTexture;
@export var projectileTextures: Array[AtlasTexture]
@export var projectileAliveTime = 1.0;
@export var projectileDamage = 10;
@export var health = 20;
@export var bulletsPierce = false;
@export var attackRecoil: float = 1.0;
@export var spriteFrames: SpriteFrames;
