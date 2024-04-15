extends Control
class_name InventoryMenu

@export var Units: Array[UnitData];
@export var Resources: Array[RessourceData];

@export var spawnButtons: VBoxContainer;
@export var inventoryList: VBoxContainer;

@export var spawnButtonPrefab: PackedScene;
@export var resourceWithCountPrefab: PackedScene;

# It's here to keep track which button corresponds to which unit
var buttonMap: Dictionary 

func refreshInventory():
	# Mass execution of children
	for child in inventoryList.get_children():
		inventoryList.remove_child(child)
	
	# Create player inventory
	for resource: ResourceWithCount in Global.playerResources:
		var inst: ResourceWithCountUI = resourceWithCountPrefab.instantiate();
		inst.setResourceWithCount(resource);
		inventoryList.add_child(inst);

func canCraft(unit: UnitData) -> bool:
	for k in unit.drops:
		if k not in Global.playerRessources:
			return false
		if Global.playerRessources[k] < unit.drops[k]:
			return false
	return true

func expendCraft(unit: UnitData) -> void:
	for k in unit.drops:
		Global.playerRessources[k] -= unit.drops[k]

func tryCraft(button: Button):
	var unit = buttonMap[button]
	if canCraft(unit):
		Global.playerUnit = unit as UnitData
		expendCraft(unit)

func _ready():
	# Create buttons
	for unit in Units:
		var spawnButton: SpawnUnitButton = spawnButtonPrefab.instantiate();
		spawnButtons.add_child(spawnButton);
		spawnButton.setUnit(unit);
		
	refreshInventory();
		
	# Add each resource to the player's inventory with count 0
	for resource in Resources:
		var resourceWithCount := ResourceWithCount.new();
		resourceWithCount.count = 0;
		resourceWithCount.resourceData = resource;
		Global.playerResources.push_back(resourceWithCount);

func _process(_delta):
	refreshInventory()
