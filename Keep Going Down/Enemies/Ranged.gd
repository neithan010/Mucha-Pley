extends BaseEnemy
#Inherits vars:
#var HP: int
#var ARMOR: int
#var MAX_SPEED: int
#var ACCEL: int
#var FRICTION: int
#var velocity:= Vector2.ZERO
#var DAMAGE: int
#var ATTACK_SPEED: int
#onready var hurtbox := $Hurtbox
#var target_player : Player
var Bullet = preload("res://Enemies/EnemyBullet.tscn")

onready var attack_sfx = $RangedAttack

func _ready():
	DAMAGE = 20
	ATTACK_SPEED = 3
	NAME = "RANGED"
	MAX_SPEED = 80.0
	XP_WORTH = 5
	start_attack_timer()


func _physics_process(delta):
	._physics_process(delta)
	advance_attack_timer(delta)
	if target_player and can_attack() and target_detected:
		shoot()
		reset_attack_timer()
		


func shoot():
	attack_sfx.play()
	var shot = Bullet.instance()
	shot.init(500, 10, position, rotation)
	owner.add_child(shot)


func target_location()->Vector2:
	var dir : Vector2 = self.global_position - target_player.global_position
	dir = dir.normalized()
#	print(dir)
	return target_player.global_position + dir*200
	
