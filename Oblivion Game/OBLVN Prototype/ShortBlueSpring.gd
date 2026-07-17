extends Area2D

onready var anim = $AnimatedSprite
onready var sfx = $sfx
export var base_bounce_force := -400.0  
export var multiplier_increment := 3   
export var max_multiplier := 12.0       
export var reset_time := 2.0            
var current_multiplier := 1.0
var reset_timer: Timer



func _on_ShortBlueSpring_body_entered(body):
	if (body.name == "AlexStates"):
		anim.play("default")
		sfx.play()
	if "velocity" in body and body.velocity.y > 0:
		body.velocity.y = base_bounce_force * current_multiplier
		current_multiplier = min(current_multiplier + multiplier_increment, max_multiplier)



func _on_ShortBlueSpring_body_exited(body):
	if (body.name == "AlexStates"):
		anim.frame = 0



func _ready():
	reset_timer = Timer.new()
	add_child(reset_timer)
	reset_timer.one_shot = true
	reset_timer.wait_time = reset_time
	reset_timer.connect("timeout", self, "_on_reset_timer_timeout")
	connect("body_entered", self, "_on_body_entered")

func _on_reset_timer_timeout():
	current_multiplier = 1.0
