extends CanvasLayer

onready var speed_label = $Speed/Label
onready var armor_label = $Armor/Label
onready var dmg_label = $Damage/Label
onready var hp_label = $Health/Label

var speed = 1
var armor = 0
var damage = 1
var health = 100

func _ready():
	speed_label.text = String(speed)
	armor_label.text = String(armor)
	dmg_label.text = String(damage)
	hp_label.text = String(health)  + "/" + String(health)
