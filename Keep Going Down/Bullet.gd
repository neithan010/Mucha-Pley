extends Node2D
class_name Bullet

var speed :int
var DAMAGE : int
var direction : Vector2
var control
var death_timer: float
var destroying :=false

onready var anim_sprite = $AnimatedSprite
onready var hurtbox = $Hurtbox
onready var hitbox = $Hitbox
onready var particles = $Particles2D

func _ready():
	hurtbox.control = self
	hitbox.control = self
	death_timer = particles.lifetime*2

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
	anim_sprite.playing = false
	anim_sprite.visible = false

func destroy():
	print("Destroying: ", self)
	
	speed = 0
	hurtbox.set_deferred("monitorable", false)
	hurtbox.set_deferred("monitoring", false)
	hitbox.set_deferred("monitorable", false)
	hitbox.set_deferred("monitoring", false)
	destroying = true
	
	particles.emitting = false
	anim_sprite.playing = true

func _on_Hurtbox_area_entered(area):#choca con algo
	destroy()

func _on_Hurtbox_body_entered(body):
	destroy()

func is_armour():
	return false
