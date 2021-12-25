extends Particles2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var lifetimer :float = lifetime + lifetime*process_material.lifetime_randomness

func init(color, pos):
	modulate = color
	emitting =  true
	position = pos

func _physics_process(delta):
	lifetimer -= delta
	if lifetimer <0:
		queue_free()
