extends Node2D
class_name Bullet

var speed :int
var DAMAGE : int
var direction : Vector2
var death_timer: float
var destroying :=false

onready var anim_sprite = $AnimatedSprite
onready var hurtbox = $Hurtbox
onready var hitbox = $Hitbox
onready var particles = $Particles2D

func _ready():
	death_timer = $Particles2D.lifetime*2

func init(spd:int, dmg:int, pos:Vector2, dir:float):
	position = pos
	
	speed = spd
	DAMAGE = dmg
	rotation = dir
	direction = Vector2(1, 0).rotated(rotation).normalized()

func _physics_process(delta):
	position += direction * speed * delta
	if destroying:
		death_timer-= delta
		if death_timer <= 0:
			queue_free()


func destroy():
	speed = 0
	DAMAGE = 0
	set_deferred("$Hurtbox.monitorable", false)
	set_deferred("$Hurtbox.monitoring", false)
	set_deferred("$Hitbox.monitorable", false)
	set_deferred("$Hitbox.monitoring", false)
	
	destroying = true
	
	particles.emitting = false
	anim_sprite.playing = true

func _on_AnimatedSprite_animation_finished():
	anim_sprite.playing = false
	anim_sprite.visible = false

func _on_Hurtbox_area_entered(_area):#choca
#	print("choca con area ", _area)
	destroy()

func _on_Hurtbox_body_entered(_body):#choca
	#print("choca con mundo ", _body, position)
	
	destroy()

func _on_Hitbox_hit(area):
#	print("ataca con area ", area)
	
	area.get_parent().receive_damage(DAMAGE)
	destroy()
