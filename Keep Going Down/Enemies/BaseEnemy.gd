extends BaseAttacker
class_name BaseEnemy


#Inherits vars:
#var HP: float
#var ARMOR: float
#var MAX_SPEED: int
#var ACCEL: int
#var FRICTION: int
#var velocity:= Vector2.ZERO
#onready var DAMAGE: int = 0
#var ATTACK_SPEED: int
#onready var ATTACK_TIMER:= ATTACK_SPEED
#onready var hurtbox := $Hurtbox

var navNode : Navigation2D
onready var navPath := PoolVector2Array()
var target_player : Player
onready var navigating := false
onready var target_detected := false
var hitbox :Hitbox
var hurtbox :Hurtbox
var navTimer :Timer
var XP_WORTH :float
var _targeted: Sprite

onready var death_sfx = $EnemyDeath

func _ready():

	hitbox = $HitboxPos/Hitbox
	hurtbox = $Hurtbox
	navTimer = $NavigationTimer
	_targeted = $TargetMarker
	set_process(false)


func face_target():
	if target_player != null:
		var vector_dir := target_player.global_position - self.global_position
		rotation = vector_dir.angle()

func _physics_process(delta):
	face_target()
	pathfinding_movement(delta)
	_targeted.rotation += delta*0.5
	

onready var _timing:= true

func advance_attack_timer(delta:float):
	if _timing and ATTACK_TIMER >0:
		ATTACK_TIMER -= delta
		if ATTACK_TIMER <= 0.0:
			return true
	return false
	
func reset_attack_timer():
	ATTACK_TIMER = ATTACK_SPEED

func stop_attack_timer():
	_timing = false
func start_attack_timer():
	_timing = true

func pathfinding_movement(delta)->void:
	if navigating:
		move_along_path(MAX_SPEED * delta * SPEED_MULT)
	

func navigate_towards(target:Vector2)->void:
#	print("nav towards: ", target)
	navPath = navNode.get_simple_path(global_position, target)
	navigating = true

func move_and_slide_towards(distance, place):
	var dir :Vector2 = place-self.position
	dir = dir.normalized()
	var _m = move_and_slide(dir*distance)

func move_along_path(distance:float)->void:
	var start_point := position
	for _i in range(navPath.size()):
		var dist_to_next := start_point.distance_to(navPath[0])
		if distance <= dist_to_next and distance >= 0.0 and dist_to_next !=0:
			position = start_point.linear_interpolate(navPath[0], distance/dist_to_next)
			break
		elif distance < 0.0:
			position = navPath[0]
			set_process(false)
			
		distance -= dist_to_next
		start_point = navPath[0]
		navPath.remove(0)

func activate(target_pl):
	if target_detected:
		return
	elif navNode == null:
#		print("no nav")
		return
	else:
#		print(NAME, " navigating towards player from detection area", area)
		target_player = target_pl
		navigate_towards(target_location())
		target_detected = true
		set_process(true)
		navTimer.start()

func deactivate():
	target_detected = false
	set_process(false)
	navTimer.stop()

func die():
	death_sfx.play()
	deathplosion($Sprite.modulate)
	if target_player != null:
		target_player.add_xp(XP_WORTH)
	var minion = get_tree().get_nodes_in_group("Minion")
	if minion.size()>0:
		minion = minion[0]
	minion.confirm_kill(self)
	
	queue_free()
#elige hacia adonde pathfindear, sobreescrito en hijos
func target_location()->Vector2:
	return target_player.global_position

func _on_NavigationTimer_timeout():
	if target_detected:
		navigate_towards(target_location())

func targeted(state:bool):
	_targeted.visible = state
#	print(self, " targeted: ", state)
