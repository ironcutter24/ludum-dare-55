extends Node

var sceneLoaded: Node = null;

func load_new_scene(newScene: PackedScene):
	if (sceneLoaded != null):
		sceneLoaded.free();
	var instantiated = newScene.instantiate();
	sceneLoaded = instantiated;
	get_tree().root.add_child(instantiated);
