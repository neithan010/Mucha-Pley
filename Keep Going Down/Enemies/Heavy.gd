extends BaseEnemy


#Inherits vars:
#var HP: int
#var ARMOR: int
#var MAX_SPEED: int
#var ACCEL: int
#var FRICTION: int
#var velocity:= Vector2.ZERO
#onready var DAMAGE: int = 0
#var ATTACK_SPEED: int
#onready var ATTACK_TIMER:= ATTACK_SPEED
#onready var hurtbox := $Hurtbox
#var navNode : Navigation2D
#onready var navPath := PoolVector2Array()
#var target_player : Player
#onready var move_speed := 120.0
#onready var navigating := false
#onready var target_detected := false
#var hitbox :Hitbox
#var hurtbox :Hurtbox
#var navTimer :Timer
var preparing_attack = false
var attack_delay_timer:= 1.0
var default_color = "5d1c1c"
var attack_color = "ec1212"
var detector :Area2D

onready var attack_sfx = $HeavyAttack

# Called when the node enters the scene tree for the first time.
func _ready():

	._ready()
	NAME = "HEAVY"
	ATTACK_SPEED = 3
	MAX_SPEED = 80.0
	XP_WORTH = 3
	DAMAGE = 20
	HP = 50
	reset_attack_timer()
	start_attack_timer()
	hitbox.NAME = "HItBOX"
	hurtbox.NAME = "HURT"
	detector = $HitboxPos/HitboxDetection
	detector.NAME = "DETECTOR"

func _physics_process(delta):
	._physics_process(delta)
	var timer_ended = advance_attack_timer(delta)
	if timer_ended:
#		print("<Heavy> Timer finished")		
		var in_attack = detector.get_overlapping_areas()
		if len(in_attack)>0:
			start_attack()
		
	if preparing_attack:
		#wait a second before starting damaging part of the attack
		attack_delay_timer -= delta
		if attack_delay_timer <0 and detector.monitoring:
			var _in_attack = detector.get_overlapping_areas()
			set_attack(true)
#			print("<Heavy> in attack area:", in_attack)
#			if len(in_attack)>0:
#				print("<Heavy> Attack area had: ", len(in_attack), ", ", in_attack, " attacknig.")
#				target_player.receive_damage(DAMAGE)
				
				
		
	else:
		pass
		#check if distanceis right
	

func set_attack(val:bool):
	$SwordPosition/SwordSprite.visible = val
	$SwordPosition/SwordSprite.frame= 0
	$SwordPosition/SwordSprite.playing = val
	detector.monitoring = not val
	reset_attack_timer()
	
	hitbox.monitorable = val
	hitbox.monitoring = val
	preparing_attack = false
	attack_delay_timer = 1.0
	if not val:
		$Sprite.modulate = default_color
	
func target_location()->Vector2:
	var dir : Vector2 = self.global_position - target_player.global_position
	dir = dir.normalized()
#	print(dir)
	return target_player.global_position + dir*35


func start_attack():
	$Sprite.modulate = attack_color
	preparing_attack = true


	



func _on_SwordSprite_animation_finished():
#	print("<heavy> finished attack animation")
	set_attack(false)#finish attack


func _on_player_detected_in_attack_range(_area):
	if ATTACK_TIMER <= 0:
#		print("<Heavy> Heavy atacando player")
		reset_attack_timer()
		start_attack()
	else:
#		print("<Heavy> Heavy waiting for attack timer")
		pass


func _on_player_entered_hitbox(_area):
#	print("<Heavy> player detected in signal")
	attack_sfx.play()
	target_player.receive_damage(DAMAGE)
