extends Node


const WALL_MASK = 1 << 0

@export var menu_scene_path: String = ""
@export var game_scene_path: String = ""
@export var hut_scene: PackedScene;

var player_controller : BaseUnit
var playerResources: Array[ResourceWithCount] # Value is ressource name, key is how much the player has
var playerUnit: UnitData # Unit the player is

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _input(event):
	if event.is_action_pressed("quit_application"):
		get_tree().quit()

func load_hut_scene():
	load_packed_scene(hut_scene);
	
	
func load_menu_scene():
	get_tree().change_scene_to_file(menu_scene_path)

func load_scene_at_path():
	get_tree().change_scene_to_file(game_scene_path)

func load_packed_scene(scene: PackedScene):
	get_tree().change_scene_to_packed(scene)
