extends Node

var sceneLoaded: Node = null;

func load_new_scene(newScene: PackedScene):
	get_tree().change_scene_to_packed(newScene)
	"""
	if (sceneLoaded != null):
		sceneLoaded.free();
	var instantiated = newScene.instantiate();
	sceneLoaded = instantiated;
	get_tree().root.add_child(instantiated);"""
