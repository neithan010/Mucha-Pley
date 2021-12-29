extends BaseMinionBody

#var MAX_SPEED:float
#var ACCEL:float
#var ATTACK_SPEED:float
#var DAMAGE:float
#
#var _hitbox:Hitbox
#var _attack_sprite:Sprite
#var _attack_timer:float
#var _timing:= true
var BULLET_SPEED := 1000.0
var bullet = preload("res://Minion/MinionBullet.tscn")

onready var attack_sfx = $RangedAttack

func _ready():
	ACCEL     = 4000
	MAX_SPEED = 30000
	
	ATTACK_SPEED = 2.0
	MAX_SPEED = 80.0
	DAMAGE = 40.0
	
	_default_color = "735014"
	_ready_color = "ffa100"
	
	_body_sprite = $Sprite
	_hitbox = null
	_attack_sprite = null
	reset_attack_timer()
	
func _physics_process(delta):
	var _t = advance_attack_timer(delta)
	if _t:
		sprite_ready(true)

func attack():
	if can_attack():
		attack_sfx.play()
		sprite_ready(false)
		reset_attack_timer()
		#shoot
		var shot:Bullet = bullet.instance()
#		print("minion pos: ", get_parent().position)
		shot.init(BULLET_SPEED, (DAMAGE * DMG_MULT), get_parent().position, global_rotation)
		get_parent().owner.add_child(shot)
#		print("shooting, ", shot)
