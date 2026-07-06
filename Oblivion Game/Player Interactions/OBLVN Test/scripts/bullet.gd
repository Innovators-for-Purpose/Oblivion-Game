extends Sprite

var speed = 520



func _ready():
	position += transform.x * 50

func _process(delta):
	position += transform.x * speed * delta


func _on_Area2D_body_entered(_body):
									# <--- Insert Stun Code
	queue_free()
