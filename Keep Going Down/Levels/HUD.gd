extends CanvasLayer

onready var player = get_node("../Player")
onready var minion = get_node("../Minion")
onready var speed_label = $Speed/Label
onready var armor_label = $Armor/Label
onready var dmg_label = $Damage/Label
onready var hp_bar = $Health/ProgressBar
onready var hp_label = $Health/ProgressBar/Label

var damage = 1

func _ready():
	player.connect("speed_changed", self, "_on_Player_speed_changed")
	minion.connect("attack_changed", self, "_on_Minion_attack_changed")
	speed_label.text = "x 1"
	armor_label.text = "0"
	dmg_label.text = "x 1"
	hp_bar.max_value = player.MAX_HP
	hp_bar.value = player.HP
	hp_label.text = str(player.HP)

func _process(delta):
	speed_label.text = "x " + str(player.SPEED_MULT)
	armor_label.text = str(player.ARMOR)
	#TODO Add DMG_MULT no minion
	dmg_label.text = "x " + str(minion.DMG_MULT)
	hp_bar.value = player.HP
	hp_label.text = str(player.HP)
