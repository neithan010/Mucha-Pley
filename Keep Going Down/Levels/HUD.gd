extends CanvasLayer

onready var player = get_node("../Player")
onready var minion = get_node("../Minion")
onready var speed_label = $Speed/Label
onready var armor_label = $Armor/Label
onready var armor_timer = $Armor/Timer
onready var dmg_label = $Damage/Label
onready var hp_bar = $Health/ProgressBar

var speed = 1
var armor_s = 0
var armor_ds = 0
var damage = 1
var max_health = 100

func _ready():
	player.connect("HP_changed", self, "_on_Player_HP_changed")
	player.connect("speed_changed", self, "_on_Player_speed_changed")
	player.connect("armor_changed", self, "_on_Player_armor_changed")
	minion.connect("attack_changed", self, "_on_Minion_attack_changed")
	armor_timer.connect("timeout", self, "_on_Timer_timeout")
	armor_timer.set_wait_time(1)
	speed_label.text = String(speed)
	armor_label.text = str(armor_s) + ":" + str(armor_ds)
	dmg_label.text = String(damage)
	hp_bar.value = max_health

func _process(delta):
	if armor_ds < 0:
		if armor_s > 0:
			armor_s -= 1
			armor_ds = 9
		else:
			armor_timer.stop()
			armor_ds = 0
	armor_label.text = str(armor_s) + ":" + str(armor_ds)

func _on_Player_HP_changed():
	var health = clamp(player.HP, 0, max_health)
	hp_bar.value = health

func _on_Player_speed_changed():
	speed = 2 #player.speed_mult
	speed_label.text = String(speed)

func _on_Player_armor_changed():
	armor_s = player.ARMOR -1
	armor_ds = 9
	armor_timer.start()
	armor_label.text = str(armor_s) + ":" + str(armor_ds)
	
func _on_Timer_timeout():
	armor_ds -= 1

func _on_Minion_attack_changed():
	damage = 2 #minion.dmg_mult
	dmg_label.text = String(damage)
