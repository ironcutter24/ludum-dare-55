extends HBoxContainer
class_name ResourceWithCountUI

@export var sprite2D: Sprite2D;
@export var richTextLabel: RichTextLabel

func setResourceWithCount(itemWithCount: ResourceWithCount):
	if (itemWithCount.resourceData.texture != null):
		sprite2D.texture = itemWithCount.resourceData.texture;
	var newString = str(itemWithCount.count);
	richTextLabel.text = newString;
