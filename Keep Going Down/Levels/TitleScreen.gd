extends CanvasLayer

onready var res
onready var play_button = $Menu/Play
onready var file_button = $Menu/File
onready var quit_button = $Menu/Quit

func _ready():
	play_button.connect("pressed", self, "on_play_pressed")
	file_button.connect("pressed", self, "on_file_pressed")
	quit_button.connect("pressed", self, "on_quit_pressed")

# TODO: debug buttons after returning from Archive.tscn
func on_play_pressed():
	res = get_tree().change_scene("res://Levels/World.tscn")
	assert(res == OK)

func on_file_pressed():
	res = get_tree().change_scene("res://Levels/Archive.tscn")
	assert(res == OK)

func on_quit_pressed():
	get_tree().quit()
