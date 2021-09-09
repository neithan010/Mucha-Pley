extends KinematicBody2D


const MAX_SPEED := 30000
const FRICTION := 3000
const ACCEL := 4000

const INPUT_NAME := "player"
const UP    = INPUT_NAME+"_up"
const DOWN  = INPUT_NAME+"_down"
const RIGHT = INPUT_NAME+"_right"
const LEFT  = INPUT_NAME+"_left"


var velocity := Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass 

func _physics_process(delta):
	var input_vector := Vector2.ZERO
	input_vector.x = Input.get_action_strength(RIGHT) - Input.get_action_strength(LEFT)
	input_vector.y = Input.get_action_strength(DOWN)  - Input.get_action_strength(UP)
	
	if input_vector != Vector2.ZERO:
		velocity += input_vector * ACCEL * delta
		velocity = velocity.clamped(MAX_SPEED * delta)
		rotation = velocity.angle()+PI/2
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	var _move = move_and_slide(velocity)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
