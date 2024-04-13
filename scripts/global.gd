extends Node


const WALL_MASK = 1 << 0

@export var menu_scene_path: String = ""
@export var game_scene_path: String = ""

var player_controller : PlayerController

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _input(event):
	if event.is_action_pressed("quit_application"):
		get_tree().quit()


func load_menu_scene():
	get_tree().change_scene_to_file(menu_scene_path)

func load_game_scene():
	get_tree().change_scene_to_file(game_scene_path)
