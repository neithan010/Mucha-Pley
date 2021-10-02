extends "res://BaseActor.gd"

class_name BaseAttacker
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var DAMAGE: int
var ATTACK_SPEED: int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func deal_damage_to(actor:BaseActor):
	actor.HP = actor.HP- self.DAMAGE
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
