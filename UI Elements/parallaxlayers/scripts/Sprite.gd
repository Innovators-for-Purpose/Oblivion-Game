tool
extends Sprite


func _process(delta):
	rotation += 0.07
	yield(get_tree().create_timer(0.1), "timeout")
