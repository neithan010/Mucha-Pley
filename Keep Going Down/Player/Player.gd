extends BaseActor
class_name Player

const INPUT_NAME := "player"
const UP    = INPUT_NAME+"_up"
const DOWN  = INPUT_NAME+"_down"
const RIGHT = INPUT_NAME+"_right"
const LEFT  = INPUT_NAME+"_left"
const DASH_LENGTH = 0.2
const DASH_RELOAD_TIME = 2
var DASH_SPEED_fin: float
var DASH_SPEED_init: float
enum STATE {move, dash}
var move_state = STATE.move
var dash_timer : float
var dash_dir : Vector2
var dash_curr_spd = 0
var dash_recharge = DASH_RELOAD_TIME

var velocity := Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	ACCEL     = 4000
	MAX_SPEED = 30000
	FRICTION  = 3000
	DASH_SPEED_fin = MAX_SPEED * 1.5
	DASH_SPEED_init = MAX_SPEED * 2.5
#	Engine.time_scale= 0.7
	
func _physics_process(delta):
	if dash_recharge>0:
		dash_recharge-=delta
	var input_vector := Vector2.ZERO
	input_vector.x = Input.get_action_strength(RIGHT) - Input.get_action_strength(LEFT)
	input_vector.y = Input.get_action_strength(DOWN)  - Input.get_action_strength(UP)
	rotation = velocity.angle()+PI/2
	
	if Input.is_action_just_pressed("player_dash") and dash_recharge <=0:
		dash_recharge = DASH_RELOAD_TIME
		dash_timer = DASH_LENGTH
		move_state = STATE.dash
		dash_dir= input_vector.normalized()
		dash_curr_spd = DASH_SPEED_init
		
		
	
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
	
#	print("recharge: ", dash_recharge)
#	print("dashing: ", dash_timer)
#	print("delta:", delta)
	move_and_slide(velocity)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
