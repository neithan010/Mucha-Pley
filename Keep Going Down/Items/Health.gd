extends BaseItem

var HP = 50

func is_armour():
	return false

func _ready():
	COLOR = "fc0303"

func _on_Hitbox_area_entered(area):
	var player = area.get_parent()
	player.get_hp(HP)
	die()
