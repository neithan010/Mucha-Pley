extends Node2D
class_name BaseItem

var deathParticles := preload("res://Enemies/DeathParticle.tscn")
var COLOR := "ffffff"
var grab_sfx
func die():
	print("Playing SFX: ", grab_sfx)
	grab_sfx.play()
	deathplosion(COLOR)
	queue_free()
	

func deathplosion(color):
	var particles = deathParticles.instance()
	particles.init(color, position)
	owner.add_child(particles)
