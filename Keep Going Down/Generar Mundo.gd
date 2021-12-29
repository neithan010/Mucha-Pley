extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var ANCHO=2
var ALTO=2

var player : Player
var enemies
var nav:Navigation2D
var entities:Node
var LISTA_HABITACIONES=[preload("res://Levels/Mapa1.tscn"),preload("res://Levels/Mapa2.1.tscn"),
preload("res://Levels/Mapa3.tscn"),preload("res://Levels/Mapa4.tscn"),
preload("res://Levels/Mapa5.tscn")]

onready var exit = $Exit

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var ancho=0
	var alto=0
	nav = $Navigation2D
	entities=$Entity
	for _i in range(ALTO):
		for _j in range(ANCHO):
			var a = LISTA_HABITACIONES[randi() % LISTA_HABITACIONES.size()]
			var nuevo_habitacion = a.instance()
			var children = nuevo_habitacion.get_children()
			var tilemap = children[0].duplicate()
			nav.add_child(tilemap)
			tilemap.position.x=ancho
			tilemap.position.y=alto
			for _e in range(1, len(children)-1):
				var entity = children[_e].duplicate()
				entities.add_child(entity)
				entity.position.x+=ancho
				entity.position.y+=alto
			ancho+=1024
		ancho=0
		alto+=1024
	player = $PlayerController.player
	for enemy in get_tree().get_nodes_in_group("Enemies"):
#		enemy.target_player = player
		enemy.navNode = nav
#	print(get_tree())
	pass # Replace with function body.


	
	
	
	
	
