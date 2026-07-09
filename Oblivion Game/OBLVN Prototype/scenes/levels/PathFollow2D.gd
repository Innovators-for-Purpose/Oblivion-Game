extends PathFollow2D


var velocity = Vector2.ZERO
var direction = 1
export var speed = 100

onready var anim = $StaticBody2D/anim



func _process(delta):
	set_offset(get_offset() + speed * delta * direction)
	
	
#	if velocity.x < 0:
#		!anim.flip_h
#	else:
#		!anim.flip_h
#
#
#	if direction == 1:
#		anim.flip_h = false
#		print(direction)
#	else:
#		anim.flip_h = true
#		print(direction)
		
#
#	if is_on_curve_end():
#		direction = -1
#	elif is_on_curve_start():
#		direction = 1
		
	
