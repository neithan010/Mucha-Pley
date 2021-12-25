extends Node2D
class_name Bullet

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var speed :int
var DAMAGE : int
var direction : Vector2
var control
var death_timer: float
var destroying :=false
func _ready():
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
	#print("Destroying: ", self)
	
	speed = 0
	set_deferred("$Hurtbox.monitorable", false)
	set_deferred("$Hurtbox.monitoring", false)
	set_deferred("$Hitbox.monitorable", false)
	set_deferred("$Hitbox.monitoring", false)
	
	destroying = true
	
	$Particles2D.emitting = false
	$AnimatedSprite.playing = true

func _on_Hurtbox_area_entered(_area):#choca con el player
	control.target_player.receive_damage(DAMAGE)
	
	destroy()

func _on_Hurtbox_body_entered(_body):#choca con el nivel
	destroy()

