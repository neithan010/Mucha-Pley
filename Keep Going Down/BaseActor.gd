extends KinematicBody2D

class_name BaseActor

var HP: float
var ARMOR: float
var MAX_SPEED: float
var SPEED_MULT: int = 1
var ACCEL: float
var FRICTION: float
var velocity:= Vector2.ZERO
var NAME := "BASENAME"
var deathParticles := preload("res://Enemies/DeathParticle.tscn")

func _ready():
	pass

func die():
	pass

func level_up(lvl):
	pass

func deathplosion(color):
	var particles = deathParticles.instance()
	particles.init(color, position)
	owner.add_child(particles)

func receive_damage(dmg:float):
	var received_dmg = max(dmg-dmg*ARMOR/100, 0)
	ARMOR = max(ARMOR-10, 0)
	HP = max(HP - received_dmg, 0)
	print("<",NAME, "> Received Damage: ", received_dmg, ", remaining: ", HP)
	if HP<=0:
		die()
