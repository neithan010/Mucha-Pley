extends Node

var player : Player
var enemies
var SPEED_MULT = 1

func _ready():
	player = $PlayerController/Player
	enemies = $Node.get_children()
	for enemy in enemies:
		enemy.target_player = player

func change_speed_mult(delta):
	SPEED_MULT = clamp(SPEED_MULT + delta, 1, 100)
	player.SPEED_MULT = SPEED_MULT
	#TODO Add SPEED_MULT to enemies
	for enemy in enemies:
		enemy.SPEED_MULT = SPEED_MULT
