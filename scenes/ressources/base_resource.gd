class_name BaseResource
extends CharacterBody2D

@export var resourceSprite: Sprite2D;
@export var resourceData: RessourceData = null:
	set(value):
		resourceData = value
		resourceSprite.texture = resourceData.texture;
