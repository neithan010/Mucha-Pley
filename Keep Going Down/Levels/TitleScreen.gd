extends CanvasLayer

onready var play_button = $Menu/Play
onready var quit_button = $Menu/Quit

func _ready():
	play_button.connect("pressed", self, "on_play_pressed")
	quit_button.connect("pressed", self, "on_quit_pressed")

func on_play_pressed():
	get_tree().change_scene("res://Levels/World.tscn")

func on_quit_pressed():
	get_tree().quit()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
