extends BaseAttacker

signal attack_changed

#Inherits vars:
#var HP: int
#var ARMOR: int
#var MAX_SPEED: int
#var ACCEL: int
#var FRICTION: int
#var velocity:= Vector2.ZERO
#var DAMAGE: int
#var ATTACK_SPEED: int

const INPUT_NAME := "minion"
const UP    	= INPUT_NAME+"_up"
const DOWN  	= INPUT_NAME+"_down"
const RIGHT 	= INPUT_NAME+"_right"
const LEFT  	= INPUT_NAME+"_left"
const ATTACK	= INPUT_NAME+"_attack"
var in_range := true

onready var player = $"../Player"
onready var attack = $Attack
onready var animation = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	ACCEL     = 4000
	MAX_SPEED = 30000
	FRICTION  = 3000

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
		_attack()
		return
		
func _attack():
	animation.play("Attack")