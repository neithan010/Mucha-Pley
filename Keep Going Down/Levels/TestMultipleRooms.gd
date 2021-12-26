extends Node


onready var nav_2d: Navigation2D = $Navigation2D

onready var player = $ActorController/PlayerController/Player

#func _input(event: InputEvent) -> void:
#	if not event is InputEventMouseButton:
#		return
#	if event.button_index != BUTTON_LEFT or not event.pressed:
#		return
#	print("Click: ", event.global_position)
#	var new_path := nav_2d.get_simple_path(character.global_position, player.global_position)
#	line.points = new_path
#	character.path = new_path
#	print("going from ", character.global_position, " to ", player.global_position)

func _ready():
	for enemy in get_tree().get_nodes_in_group("Enemies"):#$ActorController.enemies:
		enemy.navNode = nav_2d
