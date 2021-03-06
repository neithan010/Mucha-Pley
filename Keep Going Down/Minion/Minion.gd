extends KinematicBody2D


#Inherits vars:
var HP: float
var ARMOR: float
var DMG_MULT: float
var SPEED_MULT: float
var MAX_SPEED: float
var ACCEL: float
var FRICTION: float
var velocity:= Vector2.ZERO

const INPUT_NAME := "minion"
const UP    	= INPUT_NAME+"_up"
const DOWN  	= INPUT_NAME+"_down"
const RIGHT 	= INPUT_NAME+"_right"
const LEFT  	= INPUT_NAME+"_left"
const ATTACK	= INPUT_NAME+"_attack"

const CYCLE_UP    = "cycle_target_up"
const CYCLE_DOWN  = "cycle_target_down"
const CHANGE      = "minion_change"
const DESELECT    = "deselect_target"

const TARGET_RANGE = 800


var in_range := true
var body :BaseMinionBody
var clsnShape

const HeavyBody  = preload("res://Minion/MinionHeavy.tscn")
const FastBody   = preload("res://Minion/MinionFast.tscn")
const RangedBody = preload("res://Minion/MinionRanged.tscn")

const HeavyClsn  = preload("res://Minion/HeavyCollision.tscn")
const FastClsn   = preload("res://Minion/FastCollision.tscn")
const RangedClsn = preload("res://Minion/RangedCollision.tscn")

var current_target : BaseEnemy= null

onready var player = $"../Player"
onready var cycle_down_sfx = $CycleDown
onready var cycle_up_sfx = $CycleUp
#onready var attack = $Attack
#onready var animation = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	ACCEL     = 4000
	MAX_SPEED = 30000
	FRICTION  = 3000
	body = $MinionHeavy
	clsnShape = $HeavyCollision
	#change_minion_type("FAST")
	
	DMG_MULT = 1
	SPEED_MULT = 1

func copy_body_vars():
	ACCEL = body.ACCEL
	MAX_SPEED = body.MAX_SPEED
	
func change_minion_type(type:String):
	
	if type=="RANGED":
		body.queue_free()
		clsnShape.queue_free()
		body = RangedBody.instance()
		clsnShape = RangedClsn.instance()
	elif type == "HEAVY":
		body.queue_free()
		clsnShape.queue_free()
		body = HeavyBody.instance()
		clsnShape = HeavyClsn.instance()
	elif type == "FAST":
		body.queue_free()
		clsnShape.queue_free()
		body = FastBody.instance()
		clsnShape = FastClsn.instance()
	else:
		return
#	print(body)
	add_child(body)
	add_child(clsnShape)
#	copy_body_vars()

func sort_by_dist(a:Node2D, b:Node2D)->bool:
	var dist_a = global_position.distance_to(a.global_position)
	var dist_b = global_position.distance_to(b.global_position)
	return dist_a < dist_b


func target_list(dist:float):
	var all_enemies = get_tree().get_nodes_in_group("Enemies")
#	print(all_enemies, range(all_enemies.size()))
	var target_ls = []
	for enemy_index in range(all_enemies.size()):
		if global_position.distance_to(all_enemies[enemy_index].global_position) <= dist:
			target_ls.append(all_enemies[enemy_index])
	
	target_ls.sort_custom(self, "sort_by_dist")
	return target_ls


func change_target(new_target:BaseEnemy)->void:
	if is_instance_valid(current_target):
		current_target.targeted(false)
	if new_target != null:
		new_target.targeted(true)
#	print("changed target from ", current_target, " to ", new_target)
		
	current_target = new_target
	
func cycle_targets(pos:int):
	var targets = target_list(800)
	if targets.size() == 0:
		change_target(null)
	else:
		var current_index :int = targets.find(current_target)
		if current_index == -1:
			change_target(targets[0])
		else:
			var new_index = (current_index + pos)%targets.size()
			change_target(targets[new_index])


func _physics_process(delta):
	var input_vector := Vector2.ZERO
	
	if in_range:
		input_vector.x = Input.get_action_strength(RIGHT) - Input.get_action_strength(LEFT)
		input_vector.y = Input.get_action_strength(DOWN)  - Input.get_action_strength(UP)
	
	if input_vector != Vector2.ZERO:
		velocity += input_vector * ACCEL * delta * SPEED_MULT
		velocity = velocity.clamped(MAX_SPEED * delta * SPEED_MULT)
	
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	if input_vector != Vector2.ZERO and velocity != Vector2.ZERO and not is_instance_valid(current_target):
		rotation = velocity.angle()
		
		
	if is_instance_valid(current_target):
		var vector_dir := current_target.global_position - self.global_position
		var angle_dir = vector_dir.angle()
		rotation = angle_dir
	
	var _move = move_and_slide(velocity)
	
	
	if Input.is_action_just_pressed(ATTACK):
		body.DMG_MULT = self.DMG_MULT
		body.attack()
		target_list(600)
	
	if Input.is_action_just_pressed(CYCLE_DOWN):
		cycle_down_sfx.play()
		cycle_targets(+1)

	if Input.is_action_just_pressed(CYCLE_UP):
		cycle_up_sfx.play()
		cycle_targets(-1)
	
	if Input.is_action_just_pressed(DESELECT):
		change_target(null)
	
	
	
func confirm_kill(killed):
	if killed == current_target:
		cycle_targets(+1)
	if Input.is_action_pressed(CHANGE):
		change_minion_type(killed.NAME)
	
