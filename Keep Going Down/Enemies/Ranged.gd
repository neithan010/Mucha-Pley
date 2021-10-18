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


func _ready():
	DAMAGE = 20
	ATTACK_SPEED = 3


func _physics_process(delta):
	._physics_process(delta)
	if target_player and can_attack():
		shoot(target_player)
		attacked()
		


func shoot(actor:BaseActor):
	var shot = Bullet.instance()
	shot.init(500, 10, position, rotation, self)
	owner.add_child(shot)

