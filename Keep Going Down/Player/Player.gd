extends BaseActor
class_name Player

signal HP_changed
signal speed_changed
signal armor_changed

#Inherits vars:
#var HP: int
#var ARMOR: int
#var MAX_SPEED: int
#var ACCEL: int
#var FRICTION: int
#var velocity:= Vector2.ZERO

const INPUT_NAME := "player"
const UP    = INPUT_NAME+"_up"
const DOWN  = INPUT_NAME+"_down"
const RIGHT = INPUT_NAME+"_right"
const LEFT  = INPUT_NAME+"_left"
const DASH_LENGTH = 0.2
const DASH_RELOAD_TIME = 2
const MAX_HP = 100

onready var res

var DASH_SPEED_fin: float
var DASH_SPEED_init: float
enum STATE {move, dash}
var move_state = STATE.move
var dash_timer : float
var dash_dir : Vector2
var dash_curr_spd = 0
var dash_recharge = DASH_RELOAD_TIME


# Called when the node enters the scene tree for the first time.
func _ready():
	ACCEL     = 4000
	MAX_SPEED = 30000
	FRICTION  = 3000
	DASH_SPEED_fin = MAX_SPEED * 1.5
	DASH_SPEED_init = MAX_SPEED * 2.5
	HP = MAX_HP
#	Engine.time_scale= 0.7
	
func _physics_process(delta):
	if dash_recharge>0:
		dash_recharge-=delta
	var input_vector := Vector2.ZERO
	input_vector.x = Input.get_action_strength(RIGHT) - Input.get_action_strength(LEFT)
	input_vector.y = Input.get_action_strength(DOWN)  - Input.get_action_strength(UP)
	if velocity != Vector2.ZERO:
		rotation = velocity.angle()
	
	if Input.is_action_just_pressed("player_dash") and dash_recharge <=0:
		dash_recharge = DASH_RELOAD_TIME
		dash_timer = DASH_LENGTH
		move_state = STATE.dash
		dash_dir= input_vector.normalized()
		dash_curr_spd = DASH_SPEED_init
		
	if Input.is_action_just_pressed("ui_select"):
		var bullet = preload("res://Bullet.tscn").instance()
		bullet.init(500, 10, position, rotation, self)
		owner.add_child(bullet)
		print(bullet)
	
	match move_state:
		STATE.move:
			if input_vector != Vector2.ZERO:
				velocity += input_vector * ACCEL * delta
				velocity = velocity.clamped(MAX_SPEED * delta)
			else:
				velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		STATE.dash:
			#print("dashing")
			if dash_timer>0:
				dash_timer -= delta
				velocity = dash_dir * dash_curr_spd * delta
				#print(dash_curr_spd)
				var dash_diff = dash_curr_spd - DASH_SPEED_fin
				var brake = delta * dash_diff
				#print("brake. ", brake)
				dash_curr_spd = max(DASH_SPEED_fin, dash_curr_spd - brake)
				
				
			else:
				move_state = STATE.move
	
	res = move_and_slide(velocity)
	

func _on_Hurtbox_area_entered(area):
	#cuando entra una hitbox enemiga en la hurtbox del player
	#(Cuando el player recibe un ataque)
	print("Received Attack")
	print(area)
	print(area.control)
	print(area.get_area_damage())
	self.HP -= area.get_area_damage()
	emit_signal("HP_changed")
	#self.ARMOR = 2
	#emit_signal("armor_changed")
	if self.HP <= 0:
		pass
