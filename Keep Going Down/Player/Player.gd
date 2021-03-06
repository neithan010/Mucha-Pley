extends BaseActor
class_name Player



#Inherits vars:
#var HP: float
#var ARMOR: float
#var MAX_SPEED: float
#var SPEED_MULT: int
#var ACCEL: float
#var FRICTION: float
#var velocity:= Vector2.ZERO
#var NAME := "BASENAME"
#var deathParticles := preload("res://Enemies/DeathParticle.tscn")
const INPUT_NAME := "player"
const UP    = INPUT_NAME+"_up"
const DOWN  = INPUT_NAME+"_down"
const RIGHT = INPUT_NAME+"_right"
const LEFT  = INPUT_NAME+"_left"
const DASH_LENGTH = 0.2
const DASH_RELOAD_TIME = 2
const MAX_HP := 200.0
const XP_THRESHOLD = [9, 14, 300, 400, 500, 600, 700, 800, 900, 1000]

onready var res
onready var armor_timer = $ArmorTimer
onready var upgrade_sfx = $PlayerUpgrade
onready var controller = get_owner()
onready var game_over = $"../GameOverCanvas/GameOver"
onready var pause = $"../PauseCanvas/Pause"

var DASH_SPEED_fin: float
var DASH_SPEED_init: float
enum STATE {move, dash}
var move_state = STATE.move
var dash_timer : float
var dash_dir : Vector2
var dash_curr_spd = 0
var dash_recharge = DASH_RELOAD_TIME
var XP := 0.0
var LVL:int
var SCORE:float
var SCORE_MULT:float

# Called when the node enters the scene tree for the first time.
func _ready():
	NAME = "Player"
	ACCEL     = 3000
	MAX_SPEED = 20000
	FRICTION  = 3000
	ARMOR = 50
	SCORE = 0
	SCORE_MULT = 1
	DASH_SPEED_fin = MAX_SPEED * 1.5
	DASH_SPEED_init = MAX_SPEED * 2.5
	HP = MAX_HP
	LVL = 0
	armor_timer.connect("timeout", self, "_on_Timer_timeout")
	armor_timer.set_wait_time(1)
	armor_timer.start()
	print("PlayerController: ", controller)
#	Engine.time_scale= 0.5
	
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
		
#	if Input.is_action_just_pressed("ui_select"):
#		var bullet = preload("res://Minion/MinionBullet.tscn").instance()
#		bullet.init(500, 10, position, rotation, self)
#		owner.add_child(bullet)
	
	match move_state:
		STATE.move:
			if input_vector != Vector2.ZERO:
				velocity += input_vector * ACCEL * delta * SPEED_MULT
				velocity = velocity.clamped(MAX_SPEED * delta * SPEED_MULT)
			else:
				velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta * SPEED_MULT)
		STATE.dash:
			#print("dashing")
			if dash_timer>0:
				dash_timer -= delta
				velocity = dash_dir * dash_curr_spd * delta * SPEED_MULT
				#print(dash_curr_spd)
				var dash_diff = dash_curr_spd - DASH_SPEED_fin
				var brake = delta * dash_diff
				#print("brake. ", brake)
				dash_curr_spd = max(DASH_SPEED_fin, dash_curr_spd - brake)
			else:
				move_state = STATE.move
	
	res = move_and_slide(velocity)

	var _m = move_and_slide(velocity)

func _on_Timer_timeout():
	if ARMOR > 0:
		ARMOR -= 0.5
	if HP >0:
		HP -= 0.0001*LVL*MAX_HP
		if HP <= 0:
			die()
	SCORE_MULT = max(1, SCORE_MULT-0.4)

func add_xp(amt:float):
	XP += amt
	SCORE_MULT += 1
	SCORE += amt*SCORE_MULT
	if XP > LVL*15:#XP_THRESHOLD[LVL]:
		LVL += 1
		level_up(LVL)
	
func get_armor(amt:float):
	#print("<Player> Got ", amt, " armor.")7
	$ArmourUp.play()
	ARMOR += amt

func get_hp(amt:float):
	#print("<Player> Got ", amt, " hp.")
	HP = clamp(HP + amt, 0, MAX_HP)
	$HealthUp.play()

func die():
	deathplosion(Color("ffffff"))
#	print("PLAYER DEAD, GAME OVER")
	armor_timer.stop()
	reset_status()
	pause.game_over = true
	game_over.SCORE = SCORE
	game_over.show()

func level_up(lvl):
	upgrade_sfx.play()
	controller.level_up(lvl)

func _on_DetectionRange_area_entered(area):
	area.get_parent().activate(self)
#	print(global_position, position)

func _on_UndetectionRange_area_exited(area):
	area.get_parent().deactivate()
	
#func receive_damage(_dmg:float):
#	pass

func reset_status():
	var path = "res://Files/player_state.json"
	var data = {}
	data["SCORE"] = 0
	data["SCORE_MULT"] = 1
	data["LVL"] = 0
	data["HP"] = MAX_HP
	data["XP"] = 0
	data["AP"] = 50
	data["SPEED_MULT"] = 1
	data["DMG_MULT"] = 1
	var f = File.new()
	f.open(path, File.WRITE)
	f.store_string(JSON.print(data, "  ", true))
	f.close()
