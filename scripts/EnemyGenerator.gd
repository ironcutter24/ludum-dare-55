extends Node
class_name EnemyGenerator

@export var enemyScene: PackedScene;
@export var generator: GaeaGenerator2D;
@export var floorTile: Resource;
@export var enemies: Array[UnitData]
@export var player: BaseUnit;
@onready var unitsToNotCreateNear: Array[Node2D] = [player];

var enemyCount = 10;
var distBetweenUnits = 50;
var minDistFromPlayer = 200;

func generateEnemies():
	while (enemyCount > 0):
		var randTile = Vector2i(
			roundi(100.0 * (randf() - 0.5)),
			roundi(100.0 * (randf() - 0.5))
			);
		
		var isValidSquare = true;
		for x in range(-1,2):
			for y in range(-1,2):
				var tile = generator.grid.get_value(randTile + Vector2i(x,y), 0);
				if (tile != floorTile):
					isValidSquare = false;
		
		var isFarFromOthers = true;
		if isValidSquare == true:
			for enemy in unitsToNotCreateNear:
				var dist: Vector2 = toWorldPosition(randTile) - Vector2i(enemy.global_position)
				if dist.length_squared() < distBetweenUnits * distBetweenUnits:
					isFarFromOthers = false;
				if enemy == player and dist.length_squared() < minDistFromPlayer * minDistFromPlayer:
					isFarFromOthers = false;
		
		if isValidSquare and isFarFromOthers:
			spawnEnemy(randTile);

func spawnEnemy(tilePos: Vector2i):
	var inst: BaseEnemy = enemyScene.instantiate();
	get_parent().add_child(inst);
	unitsToNotCreateNear.push_back(inst);
	inst.global_position = toWorldPosition(tilePos);
	inst.setUnitData(enemies.pick_random());
	enemyCount -= 1;

func toWorldPosition(tilePos: Vector2i):
	return tilePos * Vector2i(16, 12)
