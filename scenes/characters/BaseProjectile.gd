extends Area2D
class_name BaseProjectile


@export var sprite: Sprite2D
@export var unitData: UnitData;

var aliveTimer := 10.0;
var normalizedDirection: Vector2 = Vector2(0,0);
var isPlayerBullet = false;


func refresh():
	sprite.rotation = atan2(normalizedDirection.y, normalizedDirection.x)
	sprite.texture = get_rnd_texture(unitData.projectileTextures)
	aliveTimer = unitData.projectileAliveTime;

func get_rnd_texture(texArray):
	if texArray.size() == 0: return null
	return texArray.pick_random()

func _physics_process(delta):
	global_position += delta * normalizedDirection * unitData.projectileSpeed
	aliveTimer -= delta;
	if (aliveTimer <= 0):
		queue_free();
	
	for body in get_overlapping_bodies():
		if body is BaseUnit:
			var isOppositeTeam = isPlayerBullet == (body.get_parent() is BaseEnemy)
			if isOppositeTeam:
				body.apply_damage(unitData.projectileDamage);
				if !unitData.bulletsPierce:
					queue_free();
		else:
			queue_free();
