extends Button
class_name SpawnUnitButton


@export var unitData: UnitData;
@export var animatedSprite: AnimatedSprite2D;
@export var textLabel: RichTextLabel;
@export var itemsWithCount: Array[Control];
@export var playerPrefab: PackedScene;

var pressModulate = Color.WHITE;

# Called when the node enters the scene tree for the first time.
func setUnit(_unit: UnitData):
	unitData = _unit;
	animatedSprite.sprite_frames = unitData.spriteFrames;
	textLabel.text = unitData.uniqueName;
	for i in range(unitData.prices.size()):
		itemsWithCount[i].visible = true;
		itemsWithCount[i].setResourceWithCount(unitData.prices[i]);
	
func _on_pressed():
	if (can_build()):
	
		for costResource: ResourceWithCount in unitData.prices:
			for inventoryResource: ResourceWithCount in Global.playerResources:
				if costResource.resourceData.uniqueName == inventoryResource.resourceData.uniqueName:
					inventoryResource.count -= costResource.count;
		Global.playerUnit = unitData;
		var inst: PlayerController = playerPrefab.instantiate();
		inst.global_position = Vector2(1553, 1289);
		Global.player_controller.get_parent().get_parent().add_child(inst);
		(Global.player_controller.get_parent() as PlayerController).isEnabled = false;
		inst.global_position = Vector2(1553, 1289);
		inst.isEnabled = true;
		
		

func can_build()-> bool:
	return randf() > 0.5;
	for costResource: ResourceWithCount in unitData.prices:
		for inventoryResource: ResourceWithCount in Global.playerResources:
			if costResource.resourceData.uniqueName == inventoryResource.resourceData.uniqueName:
				if inventoryResource.count < costResource.count:
					return false;
	return true;

	
func get_build_modulate():
	if (can_build()):
		return Color(0.7,0.6,0.6);
	return Color.WHITE;

func _on_button_down():
	pressModulate = Color(0.9,0.9,0.9);
	modulate = pressModulate * get_build_modulate()

func _on_button_up():
	pressModulate = Color.WHITE;
	modulate = pressModulate * get_build_modulate()
