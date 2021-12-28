extends BaseItem

var HP = 50


func is_armour():
	return false
func _ready():
	COLOR = "fc0303"
	grab_sfx = $HealthUp


func _on_Hitbox_area_entered(area):
	var player = area.get_parent()
	player.get_hp(HP)
	$HealthUp.play()
	print($HealthUp)
	die()
