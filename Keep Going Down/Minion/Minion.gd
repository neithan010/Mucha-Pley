extends KinematicBody2D


const MAX_SPEED := 30000
const FRICTION := 3000
const ACCEL := 4000

const INPUT_NAME := "minion"
const UP    = INPUT_NAME+"_up"
const DOWN  = INPUT_NAME+"_down"
const RIGHT = INPUT_NAME+"_right"
const LEFT  = INPUT_NAME+"_left"



onready var player = $"../Player"
var velocity := Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	print(player)
	pass 

func in_player_range():
#	return true
	return position.distance_to(player.position)<= player.minion_range

func _physics_process(delta):
	var input_vector := Vector2.ZERO
	if in_player_range():
		input_vector.x = Input.get_action_strength(RIGHT) - Input.get_action_strength(LEFT)
		input_vector.y = Input.get_action_strength(DOWN)  - Input.get_action_strength(UP)
	
	if input_vector != Vector2.ZERO:
		velocity += input_vector * ACCEL * delta
		velocity = velocity.clamped(MAX_SPEED * delta)
		rotation = velocity.angle()+PI/2
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	#print(player.position)
	
	var _move = move_and_slide(velocity)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
