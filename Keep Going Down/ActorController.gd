extends Node

const speed_arr = [1, 1, 2, 2, 3, 3, 4, 4, 5, 5]
const damage_arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
const file_arr = ["", "0", "", "1", "", "2", "", "3", "", "4"]

var player : Player
var minion
var enemies
var SPEED_MULT = speed_arr[0]

func _ready():
	player = $PlayerController/Player
	minion = $PlayerController/Minion
	enemies = $Node.get_children()
	for enemy in enemies:
		enemy.target_player = player

func change_speed_mult(new_speed):
	SPEED_MULT = clamp(new_speed, 1, 100)
	player.SPEED_MULT = SPEED_MULT
	minion.SPEED_MULT = SPEED_MULT
	enemies = $Node.get_children()
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
	return 1+0.3*lvl#speed_arr[lvl]

func damage_lvl(lvl):
	lvl = clamp(lvl, 0, 9)
	return 1+0.3*pow(1.2, lvl)#damage_arr[lvl]

func level_up(lvl):
	minion.DMG_MULT = damage_lvl(lvl)
	change_speed_mult(speed_lvl(lvl))
	print("Level ", lvl, "; spped: ", speed_lvl(lvl), ";DMG: ", damage_lvl(lvl))
	unlock_file(lvl)
