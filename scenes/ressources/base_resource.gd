class_name BaseResource
extends Area2D

@export var resourceSprite: Sprite2D;
@export var resourceData: RessourceData;

func Refresh():
	if (resourceData.texture != null):
		
		resourceSprite.texture = resourceData.texture;

func _process(delta):
	if has_overlapping_bodies():
		queue_free();

