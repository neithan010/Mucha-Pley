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

func _ready():
	ATTACK_SPEED = 6.0
	MAX_SPEED = 80.0
	DAMAGE = 40.0
	
	_default_color = "5d1c1c"
	_ready_color = "f43131"
	
	_body_sprite = $Sprite
	_hitbox = $Attack/Hitbox
	_hitbox.monitoring = false
	_attack_sprite = $Attack/SwordSprite
	reset_attack_timer()
	
func _physics_process(delta):
	var _t = advance_attack_timer(delta)
	if _t:
		sprite_ready(true)

func attack():
	if can_attack():
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
