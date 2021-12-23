extends Panel

onready var button_1 = $Option1/Button
onready var button_2 = $Option2/Button
onready var button_3 = $Option3/Button
onready var button_4 = $Option4/Button
onready var button_5 = $Option5/Button
onready var lock_1 = $Option1/Lock
onready var lock_2 = $Option2/Lock
onready var lock_3 = $Option3/Lock
onready var lock_4 = $Option4/Lock
onready var lock_5 = $Option5/Lock
onready var content = $FileContent

func _ready():
	content.text = ""
	# replace with memory
	var unknown_files = [false, false, false, false, false]
	lock_1.visible = unknown_files[0]
	button_1.visible = !unknown_files[0]
	lock_2.visible = unknown_files[1]
	button_2.visible = !unknown_files[1]
	lock_3.visible = unknown_files[2]
	button_3.visible = !unknown_files[2]
	lock_4.visible = unknown_files[3]
	button_4.visible = !unknown_files[3]
	lock_5.visible = unknown_files[4]
	button_5.visible = !unknown_files[4]
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
	print("pressed")
	content.text = load_text_file("res://Files/File_1.txt")

func on_2_pressed():
	content.text = load_text_file("res://Files/File_2.txt")

func on_3_pressed():
	content.text = load_text_file("res://Files/File_3.txt")

func on_4_pressed():
	content.text = load_text_file("res://Files/File_4.txt")

func on_5_pressed():
	content.text = load_text_file("res://Files/File_5.txt")
