extends Node2D
class_name BaseItem

var deathParticles := preload("res://Enemies/DeathParticle.tscn")
var COLOR := "ffffff"

func die():
	deathplosion(COLOR)
	queue_free()
	

func deathplosion(color):
	var particles = deathParticles.instance()
	particles.init(color, position)
	owner.add_child(particles)
