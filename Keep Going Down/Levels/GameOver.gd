extends Control

onready var res
onready var menu_button = $Overlay/Menu/Menu
onready var file_button = $Overlay/Menu/File
onready var quit_button = $Overlay/Menu/Quit
onready var button_sfx = $ButtonPress
onready var death_sfx = $PlayerDeath
var SCORE = 0

func _ready():
	menu_button.connect("pressed", self, "on_menu_pressed")
	file_button.connect("pressed", self, "on_file_pressed")
	quit_button.connect("pressed", self, "on_quit_pressed")

func show():
	get_tree().paused = true
	visible = true
	death_sfx.play()
	$Overlay/ScoreLabel.text = "Score\n"+str(SCORE)

func on_menu_pressed():
	button_sfx.play()
	visible = false
	get_tree().paused = false
	res = get_tree().change_scene("res://Levels/TitleScreen.tscn")
	assert(res == OK)

func on_file_pressed():
	button_sfx.play()
	visible = false
	get_tree().paused = false
	res = get_tree().change_scene("res://Levels/Archive.tscn")
	assert(res == OK)

func on_quit_pressed():
	button_sfx.play()
	get_tree().quit()

