extends StaticBody2D

onready var bossgateanim = $"../../Boss Gate/AnimatedSprite"
onready var collision_shape_2d = $"../../Boss Gate/CollisionShape2D"


func _on_Hitbox_body_entered(body):
	if (body.name == "AlexStates"):
		queue_free()
	if (body.name == "Stinger"):
		queue_free()

