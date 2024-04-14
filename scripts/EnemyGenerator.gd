extends Node
class_name EnemyGenerator

@export var enemyScene: PackedScene;
@export var generator: GaeaGenerator2D;
@export var floorTile: Resource;
var enemyCount = 20;

func generateEnemies():
	while (enemyCount > 0):
		var randTile = Vector2i(
			roundi(100.0 * (randf() - 0.5)),
			roundi(100.0 * (randf() - 0.5))
			);

		var tile = generator.grid.get_value(randTile, 0);
		if (tile == floorTile):
			spawnEnemy(randTile);
			
func spawnEnemy(pos: Vector2i):
	var inst: Node2D = enemyScene.instantiate();
	get_parent().add_child(inst);
	inst.global_position = pos * Vector2i(16, 12);
	enemyCount -= 1;
	

		# var tile = generator.grid.get_value(randTile, 0);
		# print(tile);
