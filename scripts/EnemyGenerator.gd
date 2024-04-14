extends Node
class_name EnemyGenerator

@export var enemyScene: PackedScene;
@export var generator: GaeaGenerator2D;
@export var floorTile: Resource;
@export var enemies: Array[UnitData]

var enemyCount = 20;

func generateEnemies():
	while (enemyCount > 0):
		var randTile = Vector2i(
			roundi(100.0 * (randf() - 0.5)),
			roundi(100.0 * (randf() - 0.5))
			);

		var tile = generator.grid.get_value(randTile, 0);
		var wallTile = generator.grid.get_value(randTile, 1);
		if (tile == floorTile and wallTile == null):
			spawnEnemy(randTile);
			
func spawnEnemy(pos: Vector2i):
	var inst: BaseEnemy = enemyScene.instantiate();
	get_parent().add_child(inst);
	inst.global_position = pos * Vector2i(16, 12);
	inst.setUnitData(enemies.pick_random());
	enemyCount -= 1;
	

		# var tile = generator.grid.get_value(randTile, 0);
		# print(tile);
