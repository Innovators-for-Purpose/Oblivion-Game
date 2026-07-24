extends Sprite

var speed = 520
signal shield_broken


func _ready():
	position += transform.x * 50

func _process(delta):
	position += transform.x * speed * delta


func _on_Area2D_body_entered(body):
	if "BOSS" in body.name:
		connect("shield_broken",body,"Turn_Shield_Off")
		emit_signal("shield_broken")
	queue_free()
