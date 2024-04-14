extends Node

var hasSeenIntro := false;
var hasCreatedPortal := false;

func _ready():
	Dialogic.signal_event.connect(_on_dialogic_signal)
		
func _on_dialogic_signal(argument:String):
	if argument == "intro_completed":
		StoryProgress.hasSeenIntro = true;
