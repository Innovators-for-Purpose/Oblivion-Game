extends Node2D

var speed = 2000
var direction = 1


func _physics_process(delta):
	position += transform.x * delta * speed * direction 
	
	
#FIX HITBOX OF ENEMY AND PLAYER
#FIX BULLET ROTATION WHEN PLAYER IS LEFT

func _on_Stun_Bullets_body_entered(body):
	if body.is_in_group("Enemy"):
		queue_free()
		
