extends AudioStreamPlayer2D
class_name LingeringSound

func init(global_pos:Vector2, asset:String):
	var song = load(asset)
	global_position = global_pos
	stream = song
	play()


func _on_LingeringSound_finished():
	queue_free()
