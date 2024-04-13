extends Resource
class_name RessourceData


@export var uniqueName: String # Probably not the name of it's father's second wife
@export var rarity: float # How rare it is. What this is precisely depends on implementation of spawning
@export var scene: PackedScene # The scene that represents it
	
func _init(uniqueName: String, rarity: float, scene: PackedScene):
	self.uniqueName = uniqueName
	self.rarity = rarity
	self.scene = scene
		
static func getDefaultRessources() -> Array[RessourceData]:
	var array: Array[RessourceData] = []
	
	array.append(RessourceData.new("Bone", 20, preload("res://scenes/ressources/base_ressource.tscn")))
	array.append(RessourceData.new("Sword", 5, preload("res://scenes/ressources/base_ressource.tscn")))
	array.append(RessourceData.new("Meat", 20, preload("res://scenes/ressources/base_ressource.tscn")))
	array.append(RessourceData.new("Bow", 5, preload("res://scenes/ressources/base_ressource.tscn")))
	array.append(RessourceData.new("Magic", 2.5, preload("res://scenes/ressources/base_ressource.tscn")))
	array.append(RessourceData.new("Staff", 2.5, preload("res://scenes/ressources/base_ressource.tscn")))
		
	return array


