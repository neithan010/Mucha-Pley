extends Node2D
class_name BaseMinionBody

var MAX_SPEED:float
var ACCEL:float
var ATTACK_SPEED:float
var DAMAGE:float
var DMG_MULT:int

var _hitbox:Hitbox
var _attack_sprite:AnimatedSprite
var _attack_timer:float
var _body_sprite:Sprite
var _timing:= true

var _default_color :String
var _ready_color :String

func init(pos:Vector2):
	global_position = pos

func sprite_ready(bl:bool):
	if bl:
		_body_sprite.modulate = _ready_color
	else:
		_body_sprite.modulate = _default_color

func advance_attack_timer(delta:float):
	if _timing and _attack_timer >0:
		_attack_timer -= delta
		if _attack_timer <= 0.0:
#			print("<Minion> Attack timer finished")
			return true
	return false
func reset_attack_timer():
	_attack_timer = ATTACK_SPEED
func stop_attack_timer():
	_timing = false
func start_attack_timer():
	_timing = true
func can_attack() -> bool:
	return _attack_timer <= 0
func attack():
	pass

func apply_damage(area):
	if not _hitbox.monitoring:
		return
#	for area in _hitbox.get_overlapping_areas():
	var enemy :BaseEnemy = area.get_parent()
	enemy.receive_damage(DAMAGE * DMG_MULT)

func enable_sprite(bl:bool):
	_attack_sprite.visible = bl
	_attack_sprite.frame = 0
	_attack_sprite.playing = bl
