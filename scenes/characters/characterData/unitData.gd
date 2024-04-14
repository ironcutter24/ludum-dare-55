extends Resource
class_name UnitData


@export var prices: Array[ResourceWithCount]
@export var uniqueName: String # "var uniqueName: String" is all you need to know
@export var speed: float;
@export var isSwingingAttack: bool = false;
@export var projectileSpeed: float = 50;
@export var projectileTexture: AtlasTexture;
@export var projectileAliveTime = 1.0;
@export var attackRecoil: float = 1.0;
@export var texture: AtlasTexture;

