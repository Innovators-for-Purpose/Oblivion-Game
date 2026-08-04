extends PathFollow2D



var velocity = Vector2(0,0)
var direction = 1
export var speed = 100



func _process(delta):
	set_offset(get_offset() + speed * delta * direction)
