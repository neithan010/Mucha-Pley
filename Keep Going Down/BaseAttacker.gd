extends BaseActor

class_name BaseAttacker
#Inherits vars:
#var HP: float
#var ARMOR: float
#var MAX_SPEED: int
#var ACCEL: int
#var FRICTION: int
#var velocity:= Vector2.ZERO
#onready var hurtbox := $Hurtbox
onready var DAMAGE:= 0
onready var ATTACK_SPEED: float = 0.0
onready var ATTACK_TIMER:= ATTACK_SPEED


func deal_damage_to(actor:BaseActor):
	actor.HP = actor.HP- self.DAMAGE



func can_attack() -> bool:
	return ATTACK_TIMER <= 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
