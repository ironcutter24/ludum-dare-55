extends Node

@export var startScene: PackedScene;
var sceneLoaded: Node = null;

func _ready():
	load_new_scene.call_deferred(startScene);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func load_new_scene(newScene: PackedScene):
	if (sceneLoaded != null):
		sceneLoaded.free();
	var instantiated = newScene.instantiate();
	sceneLoaded = instantiated;
	get_tree().root.add_child(instantiated);
