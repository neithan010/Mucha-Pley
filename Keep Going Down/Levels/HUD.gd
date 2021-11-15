extends CanvasLayer

onready var speed_label = $Speed/Label
onready var armor_label = $Armor/Label
onready var dmg_label = $Damage/Label
onready var hp_bar = $Health/ProgressBar

var speed = 1
var armor = 0
var damage = 1
var health = 100 setget _set_health
var max_health = 100

func _ready():
	speed_label.text = String(speed)
	armor_label.text = String(armor)
	dmg_label.text = String(damage)
	hp_bar.value = health

func _set_health(value):
	health = clamp(value, 0, max_health)
	hp_bar.value = health