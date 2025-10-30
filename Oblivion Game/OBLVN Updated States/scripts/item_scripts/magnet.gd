extends Area2D

var objs = []
var pull = false
var pull_force := 400


func _ready():
	pass

func _input(event):
	if event.is_action_pressed("click"):
		pull = true
	elif event.is_action_released("click"):
		pull = false
#		for objects in objs.size():
#			objects.position += objects.position.get_direction(get_global_mouse_position())



func _physics_process(delta):
	global_position = get_global_mouse_position()
	if pull:
		for body in get_overlapping_bodies():
			if body.is_in_group("metal") and body is RigidBody2D:
				var dir = global_position.direction_to(body.global_position)
				body.apply_central_impulse(get_global_mouse_position(),-dir * -pull_force * delta)

func _on_body_entered(body):
	if body.is_in_group("metal"):
		objs.append(body)
