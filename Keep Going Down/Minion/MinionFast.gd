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

onready var attack_sfx = $FastAttack

func _ready():
	DAMAGE = 20.0
	ATTACK_SPEED = 3.0
	MAX_SPEED = 180.0
	
	_default_color = "711579"
	_ready_color = "de0af0"
	
	_hitbox = $Attack/Hitbox
	_body_sprite = $Sprite
	print(_hitbox)
	_hitbox.monitoring = false
	_attack_sprite = $Attack/SwordSprite
	reset_attack_timer()
	
func _physics_process(delta):
	var _t = advance_attack_timer(delta)
	if _t:
		sprite_ready(true)

func attack():
	if can_attack():
		attack_sfx.play()
		sprite_ready(false)
		_hitbox.monitoring = true
		reset_attack_timer()
		enable_sprite(true)
		apply_damage()


func _on_Hitbox_area_entered(area):
	apply_damage()


func _on_SwordSprite_animation_finished():
	enable_sprite(false)
	_hitbox.monitoring = false
