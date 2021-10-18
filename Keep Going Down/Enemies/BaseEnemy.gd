extends BaseAttacker
class_name BaseEnemy


#Inherits vars:
#var HP: int
#var ARMOR: int
#var MAX_SPEED: int
#var ACCEL: int
#var FRICTION: int
#var velocity:= Vector2.ZERO
#var DAMAGE: int
#var ATTACK_SPEED: int
#onready var ATTACK_TIMER:= ATTACK_SPEED
#onready var hurtbox := $Hurtbox
var target_player : Player

func face_target():
	if target_player != null:
		var vector_dir := target_player.position - self.position
		var angle_dir = vector_dir.angle()
		rotation = angle_dir

func _physics_process(delta):
	face_target()
		
