extends Resource
class_name UnitData


@export var prices: Dictionary # Key is ressource name, value is how much is needed
@export var uniqueName: String # "var uniqueName: String" is all you need to know
@export var speed: float;
	
"""
static func getDefaultUnits() -> Array[UnitData]:
	var skeleton = UnitData.new({
			'Bone': 4,
			'Sword': 1
		},
		"Skeleton",
		preload("res://scenes/characters/base_unit.tscn")
	)
	
	var zombie = UnitData.new({
			'Meat': 4,
			'Bow': 1
		},
		"Zombie",
		preload("res://scenes/characters/base_unit.tscn")
	)
	
	var brawler = UnitData.new({
		'Meat': 16,
		},
		"Brawler",
		preload("res://scenes/characters/base_unit.tscn")
	)
		
	var wizard = UnitData.new({
		'Meat': 6,
		'Staff': 1,
		},
		"Wizard",
		preload("res://scenes/characters/base_unit.tscn")
	)
		
	return [skeleton, zombie, brawler, wizard]
	"""

