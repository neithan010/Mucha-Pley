extends Node2D
class_name BaseItem

var deathParticles := preload("res://Enemies/DeathParticle.tscn")
var COLOR := "ffffff"

func die():
#	print("Playing SFX: ", grab_sfx)
	deathplosion(COLOR)
	queue_free()
	

func deathplosion(color):
	var particles = deathParticles.instance()
	particles.init(color, position)
	get_tree().root.add_child(particles)
#	particles.global_position = global_position
