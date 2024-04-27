extends Area2D

@export var portal: Node;
@export var playerController: PlayerController
@export var dungeonScene: PackedScene;
@export var rootWitchScene: Node2D;

# Called when the node enters the scene tree for the first time.
func _ready():
	Dialogic.signal_event.connect(_on_dialogic_signal)
	if (StoryProgress.hasCreatedPortal):
		portal.visible = true;
 
func _on_dialogic_signal(argument:String):
	if argument == "shake":
		portal.visible = true;
		StoryProgress.hasCreatedPortal = true;
	if argument == "intro_completed":
		StoryProgress.isIntroCompleted = true;
		playerController.isEnabled = true;
	if argument == "finished_spawn_tutorial":
		StoryProgress.finishedSpawnTutorial = true;

func _process(_delta):
	if has_overlapping_bodies():
		Global.load_packed_scene(dungeonScene);
