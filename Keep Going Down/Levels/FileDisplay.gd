extends Panel

onready var button_1 = $Option1/Button
onready var button_2 = $Option2/Button
onready var button_3 = $Option3/Button
onready var button_4 = $Option4/Button
onready var button_5 = $Option5/Button
onready var content = $FileContent

func _ready():
	content.text = ""
	# replace with memory
	var unknown_files = [false, true, false, true, true]
	button_1.disabled = unknown_files[0]
	button_2.disabled = unknown_files[1]
	button_3.disabled = unknown_files[2]
	button_4.disabled = unknown_files[3]
	button_5.disabled = unknown_files[4]
	button_1.connect("pressed", self, "on_1_pressed")
	button_2.connect("pressed", self, "on_2_pressed")
	button_3.connect("pressed", self, "on_3_pressed")
	button_4.connect("pressed", self, "on_4_pressed")
	button_5.connect("pressed", self, "on_5_pressed")

func load_text_file(path):
	var text = ""
	var f = File.new()
	var err = f.open(path, File.READ)
	if err == OK:
		text = f.get_as_text()
	f.close()
	return text

func on_1_pressed():
	content.text = load_text_file("res://Files/File_1.txt")

func on_2_pressed():
	content.text = load_text_file("res://Files/File_2.txt")

func on_3_pressed():
	content.text = load_text_file("res://Files/File_3.txt")

func on_4_pressed():
	content.text = load_text_file("res://Files/File_4.txt")

func on_5_pressed():
	content.text = load_text_file("res://Files/File_5.txt")
