extends Control

onready var res
onready var return_button = $Overlay/Menu/Return
onready var file_button = $Overlay/Menu/File
onready var quit_button = $Overlay/Menu/Quit
onready var button_sfx = $ButtonPress

func _ready():
	return_button.connect("pressed", self, "on_return_pressed")
	file_button.connect("pressed", self, "on_file_pressed")
	quit_button.connect("pressed", self, "on_quit_pressed")

func _input(event):
	if event.is_action_pressed("pause"):
		on_return_pressed()

func on_return_pressed():
	button_sfx.play()
	var next_state = not get_tree().paused
	get_tree().paused = next_state
	visible = next_state

func on_file_pressed():
	button_sfx.play()
	visible = false
	get_tree().paused = false
	if get_tree().get_current_scene().get_name() == "Archive":
		res = get_tree().change_scene("res://Levels/TitleScreen.tscn")
	else:
		res = get_tree().change_scene("res://Levels/Archive.tscn")
	assert(res == OK)

func on_quit_pressed():
	button_sfx.play()
	get_tree().quit()
