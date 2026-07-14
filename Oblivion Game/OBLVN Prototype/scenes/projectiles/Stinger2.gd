extends KinematicBody2D

onready var target = get_parent().get_node("AlexStates")
var LifeSpan
var velocity = Vector2(1,0)
export var speed =  200
var look_once = true

func init(dir):
	if dir == -1:
		position.x -= 50000000
	else:
		position.x += 72

func _process(delta):
	if look_once:
		look_at(target.position)
		look_once = false
	position += velocity.rotated(rotation) * speed * delta


## warning-ignore:unused_argument
#func _on_Boss_Arena_detection_body_entered(_body):
#	if target:
#		look_at(target.position)
#		var direction = (target.position - position).normalized()
#		velocity = direction * speed
##		rotation = rotation + rand_range(-4.0, 4.0)
		






func _on_LifeTime_timeout():
	queue_free()


func _on_Area2D_body_entered(_body):
	queue_free()
