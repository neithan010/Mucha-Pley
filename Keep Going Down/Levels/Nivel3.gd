extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var ANCHO=2
var ALTO=2

var player : Player
var enemies
var nav:Navigation2D

var LISTA_HABITACIONES=[
preload("res://Levels/Mapa11.tscn"),preload("res://Levels/Mapa12.tscn"),
preload("res://Levels/Mapa13.tscn"),preload("res://Levels/Mapa14.tscn"),
preload("res://Levels/Mapa15.tscn")]

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var ancho=0
	var alto=0
	nav = $Navigation2D
	for _i in range(ALTO):
		for _j in range(ANCHO):
			var a = LISTA_HABITACIONES[randi() % LISTA_HABITACIONES.size()]
			a.instance()
			var nuevo_habitacion = a.instance()
			nav.add_child(nuevo_habitacion)
			
			nuevo_habitacion.position.x=ancho
			nuevo_habitacion.position.y=alto
			ancho+=1024
		ancho=0
		alto+=1024
	player = $PlayerController.player
	for enemy in get_tree().get_nodes_in_group("Enemies"):
#		enemy.target_player = player
		enemy.navNode = nav
#	print(get_tree())
	pass # Replace with function body.
