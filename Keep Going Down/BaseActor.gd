extends KinematicBody2D

class_name BaseActor

var HP: float
var ARMOR: float
var MAX_SPEED: float
var SPEED_MULT: float = 1
var ACCEL: float
var FRICTION: float
var velocity:= Vector2.ZERO
var NAME := "BASENAME"
var deathParticles := preload("res://Enemies/DeathParticle.tscn")

func _ready():
	pass

func linger_sound(asset:String):
	var sound = load("res://LingeringSound.tscn").instance()
	sound.init(global_position, asset)
	get_tree().root.add_child(sound)
	
	
func die():
	pass

func level_up(_lvl):
	pass

func deathplosion(color):
	var particles = deathParticles.instance()
	particles.init(color, global_position)
	get_parent().add_child(particles)

func receive_damage(dmg:float):
	print(NAME)
	var received_dmg = max(dmg-dmg*ARMOR/100, 0)
	ARMOR = max(ARMOR-10, 0)
	HP = max(HP - received_dmg, 0)
#	print("<",NAME, "> Received Damage: ", received_dmg, ", remaining: ", HP)
	if HP<=0:
		die()
