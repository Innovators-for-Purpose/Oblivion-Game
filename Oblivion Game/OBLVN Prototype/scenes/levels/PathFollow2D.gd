extends PathFollow2D


var velocity = Vector2(0,0)
var direction = 1
export var speed = 100

onready var anim = $"../../StaticBody2D/anim"

func _process(delta):
	set_offset(get_offset() + speed * delta * direction)

	var isLeft = velocity.x < 0
a	anim.flip_h = isLeft


	if direction == 1:
		anim.flip_h = false
	else:
		anim.flip_h = true
		
		
#	if is_on_curve_end():
#		direction = -1
#	elif is_on_curve_start():
#		direction = 1
		
	
