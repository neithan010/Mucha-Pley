extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var ANCHO=4
var ALTO=4

var player : Player
var enemies

var LISTA_HABITACIONES=[preload("res://Levels/Mapa1.tscn"),preload("res://Levels/Mapa2.tscn"),
preload("res://Levels/Mapa3.tscn"),preload("res://Levels/Mapa4.tscn"),
preload("res://Levels/Mapa5.tscn"),preload("res://Levels/Mapa6.tscn"),
preload("res://Levels/Mapa7.tscn"),preload("res://Levels/Mapa8.tscn"),
preload("res://Levels/Mapa9.tscn"),preload("res://Levels/Mapa10.tscn"),
preload("res://Levels/Mapa11.tscn"),preload("res://Levels/Mapa12.tscn"),
preload("res://Levels/Mapa13.tscn"),preload("res://Levels/Mapa14.tscn"),
preload("res://Levels/Mapa15.tscn"),preload("res://Levels/Mapa16.tscn"),
preload("res://Levels/Mapa17.tscn"),preload("res://Levels/Mapa18.tscn"),
preload("res://Levels/Mapa19.tscn"),preload("res://Levels/Mapa20.tscn"),
preload("res://Levels/Mapa21.tscn"),preload("res://Levels/Mapa22.tscn")]

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var ancho=0
	var alto=0
	for i in range(ALTO):
		for j in range(ANCHO):
			var a = LISTA_HABITACIONES[randi() % LISTA_HABITACIONES.size()]
			a.instance()
			var nuevo_habitacion = a.instance()
			add_child(nuevo_habitacion)
			
			nuevo_habitacion.position.x=ancho
			nuevo_habitacion.position.y=alto
			ancho+=1024
		ancho=0
		alto+=1024
		
	#for enemy in enemies:
	#	enemies = $nuevo_habitacion.get_children()
	#	enemy.target_player = player
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
