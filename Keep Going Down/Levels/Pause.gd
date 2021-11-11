extends Control

onready var return_button = $Overlay/Menu/Return
onready var file_button = $Overlay/Menu/File
onready var quit_button = $Overlay/Menu/Quit

func _ready():
	return_button.connect("pressed", self, "on_return_pressed")
	quit_button.connect("pressed", self, "on_quit_pressed")

func _input(event):
	if event.is_action_pressed("pause"):
		on_return_pressed()

func on_return_pressed():
	var next_state = not get_tree().paused
	get_tree().paused = next_state
	visible = next_state

func on_quit_pressed():
	get_tree().quit()
