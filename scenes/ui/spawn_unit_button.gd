extends Button
class_name SpawnUnitButton


@export var unitData: UnitData;
@export var animatedSprite: AnimatedSprite2D;
@export var textLabel: RichTextLabel;
@export var itemsWithCount: Array[Control];

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
	pass # Replace with function body.

func can_build()-> bool:
	return randf() > 0.5;
	
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
