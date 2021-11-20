extends KinematicBody2D

class_name BaseActor
# Declare member variables here. Examples:

var HP: int
var ARMOR: int
var MAX_SPEED: int
var ACCEL: int
var FRICTION: int
var velocity:= Vector2.ZERO
#onready var hurtbox := $Hurtbox


# Called when the node enters the scene tree for the first time.
func _ready():
	#hurtbox.control = self
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
