extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var player : Player
var enemies
# Called when the node enters the scene tree for the first time.
func _ready():
	player = $PlayerController/Player
	enemies = $TileMap.get_children()
	for enemy in enemies:
		enemy.target_player = player

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
