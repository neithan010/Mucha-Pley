extends BaseActor

class_name BaseAttacker
#Inherits vars:
#var HP: int
#var ARMOR: int
#var MAX_SPEED: int
#var ACCEL: int
#var FRICTION: int
#var velocity:= Vector2.ZERO
#onready var hurtbox := $Hurtbox
var DAMAGE: int
var ATTACK_SPEED: float
onready var ATTACK_TIMER:= ATTACK_SPEED

func _physics_process(delta):
	ATTACK_TIMER = max(0, ATTACK_TIMER-delta)

func deal_damage_to(actor:BaseActor):
	actor.HP = actor.HP- self.DAMAGE


func attacked() -> void:
	ATTACK_TIMER = ATTACK_SPEED

func can_attack() -> bool:
	return ATTACK_TIMER <= 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
