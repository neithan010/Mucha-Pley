extends Node2D
class_name Bullet

var speed :int
var DAMAGE : int
var direction : Vector2
var control
var death_timer: float
var destroying :=false
func _ready():
	$Hurtbox.control = self
	$Hitbox.control = self
	death_timer = $Particles2D.lifetime*2

func init(spd:int, dmg:int, pos:Vector2, dir:float, ctrl):
	position = pos
	speed = spd
	DAMAGE = dmg
	rotation = dir
	direction = Vector2(1, 0).rotated(rotation).normalized()
	control = ctrl

func _physics_process(delta):
	position += direction * speed * delta
	if destroying:
		death_timer-= delta
		if death_timer <= 0:
			queue_free()

func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.playing = false
	$AnimatedSprite.visible = false

func destroy():
	print("Destroying: ", self)
	
	speed = 0
	$Hurtbox.monitorable = false
	$Hurtbox.monitoring = false
	$Hitbox.monitorable = false
	$Hitbox.monitoring = false
	destroying = true
	
	$Particles2D.emitting = false
	$AnimatedSprite.playing = true

func _on_Hurtbox_area_entered(area):#choca con algo
	destroy()

func _on_Hurtbox_body_entered(body):
	destroy()
