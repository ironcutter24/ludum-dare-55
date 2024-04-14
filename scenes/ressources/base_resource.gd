class_name BaseResource
extends CharacterBody2D

@export var resourceSprite: Sprite2D;
@export var resourceData: RessourceData;

func Refresh():
	if (resourceData.texture != null):
		
		resourceSprite.texture = resourceData.texture;
	
