extends KinematicBody2D

var gravity = 10
var velocity = Vector2(0,0)

var speed = 35

onready var anim = $Anim

		
func _process(_delta):
	move_character()

func move_character():
	velocity.x = -speed
	velocity.y += gravity
	velocity = move_and_slide(velocity, Vector2.UP)
	
func _on_Area2D_body_entered(body):
	if (body.name == "AlexStates"):
			queue_free()
			

#func _on_Area_body_entered(body):
#	if (body.name == "Guard"):
#		velocity.x = speed
#		velocity.y += gravity
#		velocity = move_and_slide(velocity, Vector2.UP)


func _on_Direction_Detection_body_entered(body):
		
	var isLeft = velocity.x > 0
	anim.flip_h = isLeft
	velocity.x = speed
	if velocity.x > 0:
		anim.flip_h = true
	elif velocity.x < 0:
		anim.flip_h = false
