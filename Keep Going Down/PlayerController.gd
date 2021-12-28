extends Node

const normalColor := ["#00fcd9", "#006abb"]
onready var player := $Player
onready var minion := $Minion
onready var line   :Line2D= $Line2D

func ready():
	#minion.player = player
	pass

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
	print("minion: ", minion.global_position, "; player: ", player.global_position, ", line: ", line.points)

func level_up(_lvl):
	pass#controller.level_up(lvl)
