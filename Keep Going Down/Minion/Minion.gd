extends KinematicBody2D

signal attack_changed

#Inherits vars:
var HP: float
var ARMOR: float
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

var in_range := true
var body :BaseMinionBody
var clsnShape

const HeavyBody  = preload("res://Minion/MinionHeavy.tscn")
const FastBody   = preload("res://Minion/MinionFast.tscn")
const RangedBody = preload("res://Minion/MinionRanged.tscn")

const HeavyClsn  = preload("res://Minion/HeavyCollision.tscn")
const FastClsn   = preload("res://Minion/FastCollision.tscn")
const RangedClsn = preload("res://Minion/RangedCollision.tscn")


onready var player = $"../Player"
#onready var attack = $Attack
#onready var animation = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	ACCEL     = 4000
	MAX_SPEED = 30000
	FRICTION  = 3000
	body = $MinionHeavy
	clsnShape = $HeavyCollision
	change_minion_type("RANGED")
	

func copy_body_vars():
	ACCEL = body.ACCEL
	MAX_SPEED = body.MAX_SPEED
	
func change_minion_type(type:String):
	body.queue_free()
	clsnShape.queue_free()
	if type=="RANGED":
		body = RangedBody.instance()
		clsnShape = RangedClsn.instance()
	elif type == "HEAVY":
		body = HeavyBody.instance()
		clsnShape = HeavyClsn.instance()
	elif type == "FAST":
		body = FastBody.instance()
		clsnShape = FastClsn.instance()
	print(body)
	add_child(body)
	add_child(clsnShape)
#	copy_body_vars()


	

func _physics_process(delta):
	var input_vector := Vector2.ZERO
	
	if in_range:
		input_vector.x = Input.get_action_strength(RIGHT) - Input.get_action_strength(LEFT)
		input_vector.y = Input.get_action_strength(DOWN)  - Input.get_action_strength(UP)
	
	if input_vector != Vector2.ZERO:
		velocity += input_vector * ACCEL * delta
		velocity = velocity.clamped(MAX_SPEED * delta)
		
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	if velocity != Vector2.ZERO:
		rotation = velocity.angle()
	
	var _move = move_and_slide(velocity)
	
	
	if Input.is_action_just_pressed(ATTACK):
		body.attack()
		return

