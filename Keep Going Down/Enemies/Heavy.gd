extends BaseEnemy


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var hitbox


# Called when the node enters the scene tree for the first time.
func _ready():
	DAMAGE = 20
	ATTACK_SPEED = 10
	hitbox = get_node("Position2D/Hitbox")
	hitbox.control = self


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
