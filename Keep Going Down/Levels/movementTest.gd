extends KinematicBody2D


var speed := 400.0
var path := PoolVector2Array() setget set_path


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(_delta):
	#print(global_position)
	pass
	
func _process(delta)->void:
	var move_distance = speed * delta
	move_along_path(move_distance)
	
	
func move_along_path(distance:float)->void:
	var start_point := position
	for _i in range(path.size()):
		var dist_to_next := start_point.distance_to(path[0])
		if distance <= dist_to_next and distance >= 0.0:
			position = start_point.linear_interpolate(path[0], distance/dist_to_next)
			break
		elif distance < 0.0:
			position = path[0]
			set_process(false)
			
		distance -= dist_to_next
		start_point = path[0]
		path.remove(0)




func set_path(value: PoolVector2Array) -> void:
	path = value
	if value.size() == 0:
		return 
	set_process(true)
