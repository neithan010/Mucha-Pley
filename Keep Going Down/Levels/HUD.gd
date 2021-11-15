extends CanvasLayer

onready var player = get_node("../Player")
onready var minion = get_node("../Minion")
onready var speed_label = $Speed/Label
onready var armor_label = $Armor/Label
onready var dmg_label = $Damage/Label
onready var hp_bar = $Health/ProgressBar

var speed = 1
var armor = 0
var damage = 1
var max_health = 100

func _ready():
	player.connect("HP_changed", self, "_on_Player_HP_changed")
	player.connect("speed_changed", self, "_on_Player_speed_changed")
	player.connect("armor_changed", self, "_on_Player_armor_changed")
	minion.connect("attack_changed", self, "_on_Minion_attack_changed")
	speed_label.text = String(speed)
	armor_label.text = String(armor)
	dmg_label.text = String(damage)
	hp_bar.value = max_health

func _on_Player_HP_changed():
	var health = clamp(player.HP, 0, max_health)
	hp_bar.value = health

func _on_Player_speed_changed():
	speed = 2 #player.speed_mult
	speed_label.text = String(speed)

func _on_Player_armor_changed():
	armor = 20 #player.armor_time
	armor_label.text = String(armor)

func _on_Minion_attack_changed():
	damage = 2 #minion.dmg_mult
	dmg_label.text = String(damage)
