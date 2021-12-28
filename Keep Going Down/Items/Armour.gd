extends BaseItem

var ARMOR = 50

func _ready():
	grab_sfx = $ArmourUp
	COLOR = "30fc03"

func _on_Hitbox_area_entered(area):
	var player = area.get_parent()
	player.get_armor(ARMOR)
	die()
