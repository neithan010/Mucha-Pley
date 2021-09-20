extends Node


onready var player := $Player
onready var minion := $Minion
onready var line   := $Line2D

func _process(delta):
	line.set_point_position(0, player.position)
	line.set_point_position(1, minion.position)
	#line.
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
