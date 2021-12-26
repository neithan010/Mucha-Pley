extends BaseEnemy
#Inherits vars:
#var HP: int
#var ARMOR: int
#var MAX_SPEED: int
#var ACCEL: int
#var FRICTION: int
#var velocity:= Vector2.ZERO
#var DAMAGE: int
#var ATTACK_SPEED: int
#onready var ATTACK_TIMER:= ATTACK_SPEED
#onready var hurtbox := $Hurtbox
#var target_player : Player


# Called when the node enters the scene tree for the first time.
func _ready():
	DAMAGE = 20
	NAME = "TRASH"
	ATTACK_SPEED = 10
	ACCEL = int(800 * rand_range(0.95, 1.05))
	MAX_SPEED = int(25000* rand_range(0.95, 1.05))
	FRICTION = 300
	XP_WORTH = 0.1
	
func _physics_process(delta):
	._physics_process(delta)
	if target_player != null:
		var vector_dir := target_player.position - self.position
		vector_dir = vector_dir.normalized()
		if vector_dir != Vector2.ZERO:
			velocity += vector_dir * ACCEL * delta
			velocity = velocity.clamped(MAX_SPEED * delta)
		else:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	else:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	velocity = move_and_slide(velocity)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func navigate_towards(target:Vector2)->void:
	pass #sobreescrito para que no haga pathfinding

func pathfinding_movement(delta):
	pass #sobreescrito para que no haga pathfinding


func _on_Hitbox_area_entered(area):
	target_player.receive_damage(DAMAGE)
