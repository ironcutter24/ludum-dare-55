extends Node

var isIntroCompleted := false;
var hasCreatedPortal := false;
var hasDiedOnce := false;

func _ready():
	Dialogic.signal_event.connect(_on_dialogic_signal)
		
func _on_dialogic_signal(argument:String):
	if argument == "intro_completed":
		StoryProgress.isIntroCompleted = true;
