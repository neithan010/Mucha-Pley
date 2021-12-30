extends Node2D

var LVL: int
var HP: float
var XP: float
var AP: float
var SPEED_MULT: float
var DMG_MULT: float

onready var path = "res://Files/player_state.json"
onready var change_lvl = $ChangeLevel
onready var current_lvl = int(get_tree().get_current_scene().get_name()[-1])
onready var controller = get_tree().get_nodes_in_group("PlayerController")[0]
onready var player = controller.player
onready var minion = controller.minion

func _ready():
	_load_state()

func _load_state():
	var f = File.new()
	f.open(path, File.READ)
	var json = JSON.parse(f.get_as_text())
	f.close()
	var data = json.result
	player.SCORE = data["SCORE"]
	player.SCORE_MULT = data["SCORE_MULT"]
	player.LVL = data["LVL"]
	player.HP = data["HP"]
	player.XP = data["XP"]
	player.ARMOR = data["AP"]
	player.SPEED_MULT = data["SPEED_MULT"]
	minion.SPEED_MULT = data["SPEED_MULT"]
	var enemies = get_tree().get_nodes_in_group("Enemies")
	for enemy in enemies:
		enemy.SPEED_MULT = data["SPEED_MULT"]
	minion.DMG_MULT = data["DMG_MULT"]

func _write_state(player):
	var data = {}
	data["SCORE"] = player.SCORE
	data["SCORE_MULT"] = player.SCORE_MULT
	data["LVL"] = player.LVL
	data["HP"] = player.HP
	data["XP"] = player.XP
	data["AP"] = player.ARMOR
	data["SPEED_MULT"] = player.SPEED_MULT
	var minion = player.get_parent().minion
	data["DMG_MULT"] = minion.DMG_MULT
	var f = File.new()
	f.open(path, File.WRITE)
	f.store_string(JSON.print(data, "  ", true))
	f.close()

func _on_Hitbox_area_entered(area):
	var player = area.get_parent()
	_write_state(player)
	change_lvl.play()
	if current_lvl == 4:
		var res = get_tree().change_scene("res://Levels/EndScreen.tscn")
		assert(res == OK)
	else:
		var res = get_tree().change_scene("res://Levels/Nivel" + str(current_lvl+1) + ".tscn")
		assert(res == OK)
