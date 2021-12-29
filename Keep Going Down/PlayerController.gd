extends Node

const normalColor := ["#00fcd9", "#006abb"]
const speed_arr = [1, 1, 2, 2, 3, 3, 4, 4, 5, 5]
const damage_arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
const file_arr = ["", "0", "", "1", "", "2", "", "3", "", "4"]

onready var player := $Player
onready var minion := $Minion
onready var line   :Line2D= $Line2D
onready var SPEED_MULT = 1

var enemies

func _physics_process(_delta):
	line.set_point_position(0, player.global_position)
	line.set_point_position(1, minion.global_position)
	if minion.global_position.distance_to(player.global_position)> 500:
		line.gradient.set_color(0, Color(1, 0, 0))
		line.gradient.set_color(1, Color(1, 0, 0))
		minion.in_range = false
	else:
		minion.in_range = true
		line.gradient.set_color(0, Color("#00fcd9"))
		line.gradient.set_color(1, Color("#006abb"))

func change_speed_mult(new_speed):
	SPEED_MULT = clamp(new_speed, 1, 100)
	player.SPEED_MULT = SPEED_MULT
	minion.SPEED_MULT = SPEED_MULT
	enemies = get_tree().get_nodes_in_group("Enemies")
	for enemy in enemies:
		enemy.SPEED_MULT = SPEED_MULT

func unlock_file(lvl):
	lvl = clamp(lvl, 0, 9)
	var index = file_arr[lvl]
	if index != "":
		var path = "res://Files/unknown_files.json"
		
		var f = File.new()
		f.open(path, File.READ)
		var json = JSON.parse(f.get_as_text())
		print("is null: ", json.result == null) 
		f.close()
		var data = json.result

		data[index] = false

		f = File.new()
		f.open(path, File.WRITE)
		f.store_string(JSON.print(data, "  ", true))
		f.close()

func speed_lvl(lvl):
	lvl = clamp(lvl, 0, 9)
	return speed_arr[lvl]

func damage_lvl(lvl):
	lvl = clamp(lvl, 0, 9)
	return damage_arr[lvl]

func level_up(lvl):
	minion.DMG_MULT = damage_lvl(lvl)
	change_speed_mult(speed_lvl(lvl))
	unlock_file(lvl)
