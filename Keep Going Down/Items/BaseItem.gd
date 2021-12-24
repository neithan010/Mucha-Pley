extends Node2D
class_name BaseItem

var destroying = false
var death_timer = 2.0

onready var hitbox = $Hitbox
onready var hurtbox = $Hurtbox

func _ready():
	hitbox.control = self
	hurtbox.control = self

func _physics_process(delta):
	if destroying:
		death_timer-= delta
		if death_timer <= 0:
			pass#queue_free()

func destroy():
	print("Destroying")
	hitbox.set_deferred("monitorable", false)
	hitbox.set_deferred("monitoring", false)
	destroying = true

func _on_Hurtbox_area_entered(area):
	destroy()

func _on_Hurtbox_body_entered(body):
	destroy()
