extends CanvasLayer

onready var res
onready var menu = $Menu
onready var credits = $Credits/RichTextLabel
onready var play_button = $Menu/Play
onready var file_button = $Menu/File
onready var quit_button = $Menu/Quit
onready var credit_button = $Menu/Credit
onready var close_button = $Credits/Close

func _ready():
	play_button.connect("pressed", self, "on_play_pressed")
	file_button.connect("pressed", self, "on_file_pressed")
	quit_button.connect("pressed", self, "on_quit_pressed")
	credit_button.connect("pressed", self, "on_credit_pressed")
	close_button.connect("pressed", self, "on_close_pressed")

# TODO: debug buttons after returning from Archive.tscn
func on_play_pressed():
	res = get_tree().change_scene("res://Levels/World.tscn")
	assert(res == OK)

func on_file_pressed():
	res = get_tree().change_scene("res://Levels/Archive.tscn")
	assert(res == OK)

func on_quit_pressed():
	get_tree().quit()

func on_credit_pressed():
	menu.visible = false
	credits.visible = true
	close_button.visible = true

func on_close_pressed():
	credits.visible = false
	close_button.visible = false	
	menu.visible = true
