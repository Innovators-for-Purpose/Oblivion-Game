extends Area2D

onready var anim = $Anim


onready var lazer = $"."

onready var timer = $Timer

#func _ready():
##	lazer.enabled = true
##	timer.wait_time = 10.0
##	timer.start()
#	timer.connect("timeout", self, "_on_Timer_timeout")



func _on_Timer_timeout():
#	self.visible = !self.visible
	$CollisionShape2D.disabled = !$CollisionShape2D.disabled
#	$Anim.disabled = !$Anim.disabled
	visible = !visible

#	anim.visible = false
#	anim.hide()
	
func _on_Area2D_body_entered(body):
	if (body.name == "AlexStates"):
		get_tree().reload_current_scene()





#	anim.visible = not $Sprite2D.visible
#func _ready():
#	lazer.enabled = true
#	$Timer.start()
#	anim.visible = true
#	anim.show()
#
#func _on_timer_timeout():
#	lazer.enabled = !lazer.enabled
#
#	anim.visible = false
#	anim.hide()
#



