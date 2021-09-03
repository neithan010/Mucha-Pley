extends KinematicBody2D


const MAX_SPEED := 30000
const FRICTION := 3000
const ACCEL := 4000

var velocity := Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var input_vector := Vector2.ZERO
	input_vector.x = Input.get_action_strength("minion_right")-Input.get_action_strength("minion_left")
	input_vector.y = Input.get_action_strength("minion_down")-Input.get_action_strength("minion_up")
	
	if input_vector != Vector2.ZERO:
		velocity += input_vector * ACCEL * delta
		velocity = velocity.clamped(MAX_SPEED * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	move_and_slide(velocity)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
