extends PathFollow2D

var velocity = Vector2(0,0)
var direction = 1
export var speed = 100
onready var sprite = $"../../BEE BOSS/Sprite"


onready var stinger_projectile = $"../../BEE BOSS/StingerProjectile"

#func _process(delta):
	#set_offset(get_offset() + speed * delta * direction)

	#var isLeft = velocity.x < 0
	#sprite.flip_h = isLeft


	#if direction == 1:
		#sprite.flip_h = false
	#else:
		#sprite.flip_h = true
		
