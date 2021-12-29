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

onready var DAMAGE:float= 0
onready var DMG_MULT: float = 1
onready var ATTACK_SPEED: float = 0.0
onready var ATTACK_TIMER:float= ATTACK_SPEED



func can_attack() -> bool:
	return ATTACK_TIMER <= 0
