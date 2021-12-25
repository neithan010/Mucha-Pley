extends BaseItem

var ARMOR = 5

func _ready():
	COLOR = "30fc03"

func _on_Hitbox_area_entered(area):
	var player = area.get_parent()
	player.get_armor(ARMOR)
	die()
