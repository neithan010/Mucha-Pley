extends Node

const normalColor := ["#00fcd9", "#006abb"]
onready var player := $Player
onready var minion := $Minion
onready var line   := $Line2D
func ready():
	#minion.player = player
	pass

func _process(delta):
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
		
	#line.
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
