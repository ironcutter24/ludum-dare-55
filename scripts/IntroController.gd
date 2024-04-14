extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	if (!StoryProgress.hasSeenIntro):
		Dialogic.start_timeline("intro")
