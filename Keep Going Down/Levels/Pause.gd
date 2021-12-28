extends Control

onready var res
onready var return_button = $Overlay/Menu/Return
onready var menu_button = $Overlay/Menu/Menu
onready var quit_button = $Overlay/Menu/Quit
onready var button_sfx = $ButtonPress
onready var game_over = false

func _ready():
	return_button.connect("pressed", self, "on_return_pressed")
	menu_button.connect("pressed", self, "on_menu_pressed")
	quit_button.connect("pressed", self, "on_quit_pressed")

func _input(event):
	if event.is_action_pressed("pause"):
		if !game_over:
			on_return_pressed()

func on_return_pressed():
	button_sfx.play()
	var next_state = not get_tree().paused
	get_tree().paused = next_state
	visible = next_state

func on_menu_pressed():
	button_sfx.play()
	get_tree().paused = false
	res = get_tree().change_scene("res://Levels/TitleScreen.tscn")
	assert(res == OK)

func on_quit_pressed():
	button_sfx.play()
	get_tree().quit()
