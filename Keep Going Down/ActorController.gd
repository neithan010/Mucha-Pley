extends Node

const speed_arr = [1, 1, 2, 2, 3, 3, 4, 4, 5, 5]
const damage_arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

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
	for enemy in enemies:
		enemy.SPEED_MULT = SPEED_MULT

func speed_lvl(lvl):
	lvl = clamp(lvl, 0, 9)
	return speed_arr[lvl]

func damage_lvl(lvl):
	lvl = clamp(lvl, 0, 9)
	return damage_arr[lvl]

func level_up(lvl):
	minion.DMG_MULT = damage_lvl(lvl)
