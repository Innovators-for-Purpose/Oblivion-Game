extends KinematicBody2D

var speed = 520



func _ready():
	position += transform.x * 50

func _process(delta):
	position += transform.x * speed * delta


func _on_Area2D_body_entered(body):
	if "Guard" in body.name:
		var timer = get_tree().create_timer(2)
		speed = 0
		$Sprite.hide()
		$trail.hide()
		$pop.emitting = true
		yield(timer,"timeout")
		queue_free()
	if "BOSS1" in body.name:
		$Sprite.flip_h = !$Sprite.flip_h
		speed = -speed
		print("OH NAWW")
#	queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
