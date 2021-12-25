extends KinematicBody2D

class_name BaseActor
# Declare member variables here. Examples:

var HP: float
var ARMOR: float
var MAX_SPEED: float
var ACCEL: float
var FRICTION: float
var velocity:= Vector2.ZERO
var NAME := "BASENAME"
var deathParticles := preload("res://Enemies/DeathParticle.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func die():
	pass

func deathplosion(color):
	var particles = deathParticles.instance()
	particles.init(color, position)
	owner.add_child(particles)

func receive_damage(dmg:float):
	var received_dmg =max(dmg-dmg*ARMOR/100, 0)
	ARMOR = max(ARMOR-10, 0)
	HP -= received_dmg
	print("<",NAME, "> Received Damage: ", received_dmg, ", remaining: ", HP)
	if HP<=0:
		die()

