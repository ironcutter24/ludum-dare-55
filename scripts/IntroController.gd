extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	if (!StoryProgress.isIntroCompleted):
		Dialogic.start_timeline("intro")
	elif (StoryProgress.hasDiedOnce and !StoryProgress.hasSeenSpawnTutorial):
		StoryProgress.hasSeenSpawnTutorial = true;
		Dialogic.start_timeline("spawn_tutorial")
