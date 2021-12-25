extends CanvasLayer

onready var player = get_node("../Player")
onready var minion = get_node("../Minion")
onready var speed_label = $Speed/Label
onready var armor_label = $Armor/Label
onready var armor_timer = $Armor/Timer
onready var dmg_label = $Damage/Label
onready var hp_bar = $Health/ProgressBar
onready var hp_label = $Health/ProgressBar/Label
onready var max_health = player.MAX_HP
onready var health = clamp(player.HP, 0, max_health)

var speed = 1
var armor = 0
var damage = 1

func _ready():
	player.connect("HP_changed", self, "_on_Player_HP_changed")
	player.connect("speed_changed", self, "_on_Player_speed_changed")
	player.connect("armor_changed", self, "_on_Player_armor_changed")
	minion.connect("attack_changed", self, "_on_Minion_attack_changed")
	armor_timer.connect("timeout", self, "_on_Timer_timeout")
	armor_timer.set_wait_time(1)
	speed_label.text = "x " + str(speed)
	armor_label.text = str(armor)
	dmg_label.text = "x " + str(damage)
	hp_bar.max_value = max_health
	hp_bar.value = health
	hp_label.text = str(max_health)

func _process(delta):
	if armor < 0:
		armor_timer.stop()
		armor = 0
	armor_label.text = str(armor)

func _on_Player_HP_changed():
	health = clamp(player.HP, 0, max_health)
	hp_bar.value = health
	hp_label.text = str(health)

func _on_Player_speed_changed():
	speed = 2 #player.speed_mult
	speed_label.text = "x " + str(speed)

func _on_Player_armor_changed():
	armor = player.ARMOR -1
	armor_timer.start()
	armor_label.text = str(armor)
	
func _on_Timer_timeout():
	armor -= 1

func _on_Minion_attack_changed():
	damage = 2 #minion.dmg_mult
	dmg_label.text = "x " + str(damage)
