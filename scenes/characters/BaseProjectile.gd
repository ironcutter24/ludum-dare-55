extends Area2D
class_name BaseProjectile

var aliveTimer := 10.0;
@export var sprite: Sprite2D;
var normalizedDirection: Vector2 = Vector2(0,0);
@export var unitData: UnitData;
var isPlayerBullet = false;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func refresh():
	sprite.texture = unitData.projectileTextures.pick_random()
	aliveTimer = unitData.projectileAliveTime;

func _process(delta):
	global_position += delta * normalizedDirection * unitData.projectileSpeed
	aliveTimer -= delta;
	if (aliveTimer <= 0):
		queue_free();
	
	for body in get_overlapping_bodies():
		
		if body is BaseUnit:
			var isOppositeTeam = isPlayerBullet == (body.get_parent() is BaseEnemy)
			if isOppositeTeam:
				body.Health -= unitData.projectileDamage;
				if !unitData.bulletsPierce:
					queue_free();
					
			

