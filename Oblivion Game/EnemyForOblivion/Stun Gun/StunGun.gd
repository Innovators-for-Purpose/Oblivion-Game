extends Sprite

var mouse_pos: Vector2
#onready var stun_gun = $StunGun
#var player_direction = get_parent().direction

func _ready():
	pass
	
func _physics_process(_delta):
	var min_rotate = deg2rad(-45) 
	var max_rotate = deg2rad(45)

	var mouse_pos = get_global_mouse_position()
	mouse_pos = lerp(mouse_pos, get_global_mouse_position(), 0.1)
	look_at(mouse_pos)
	#The next 3 lines is the code that limits the gun's rotation
	var raw_direction = get_global_mouse_position() - global_position
	var direction = Vector2(abs(raw_direction.x), raw_direction.y)
	var angle
	if (get_parent().direction > 0):
		angle = direction.angle()
	else:
		angle = -direction.angle()
	rotation = clamp(angle, min_rotate, max_rotate)

