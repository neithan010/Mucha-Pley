extends Node

const normalColor := ["#00fcd9", "#006abb"]
onready var player := $Player
onready var minion := $Minion
onready var line   := $Line2D
onready var controller = get_owner()

func ready():
	#minion.player = player
	pass

func _process(_delta):
	line.set_point_position(0, player.position)
	line.set_point_position(1, minion.position)
	if minion.position.distance_to(player.position)> 400:
		line.gradient.set_color(0, Color(1, 0, 0))
		line.gradient.set_color(1, Color(1, 0, 0))
		minion.in_range = false
	else:
		minion.in_range = true
		line.gradient.set_color(0, Color("#00fcd9"))
		line.gradient.set_color(1, Color("#006abb"))

func level_up(lvl):
	controller.level_up(lvl)
