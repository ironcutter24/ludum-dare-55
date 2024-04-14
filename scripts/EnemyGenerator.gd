extends Node
class_name EnemyGenerator

@export var enemyScene: PackedScene;
@export var generator: GaeaGenerator2D;
var enemyCount = 20;

func _ready():
	generateEnemies();
	
func generateEnemies():
	while (enemyCount > 0):
		var randTile = Vector2i(100.0 * (randf() - 0.5),100.0 * (randf() - 0.5));
		enemyCount -= 1;
		# print(generator.grid.get_cells(0));
		# var tile = generator.grid.get_value(randTile, 0);
		# print(tile);
