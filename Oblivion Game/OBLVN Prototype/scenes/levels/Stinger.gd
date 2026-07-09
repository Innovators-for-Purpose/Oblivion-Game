extends Area2D

onready var target = $"../../AlexStates"

var velocity = Vector2.ZERO
export var speed =  5


func _physics_process(delta):
	if target:
		var direction = (target.position - position).normalized()
		velocity = direction * speed
		look_at(target.position)
		
	position += velocity * delta


# warning-ignore:unused_argument
func _on_Boss_Arena_detection_body_entered(body):
	if target:
		var direction = (target.position - position).normalized()
		velocity = direction * speed
		look_at(target.position)
	else:
		pass
		



func _on_StingerKill_body_entered(body):
	if (body.name == "AlexStates"):
# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()
