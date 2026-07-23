extends Area2D

onready var anim = $anim
onready var sfx = $sfx
onready var cpu_particles_2d = $CPUParticles2D


func _on_Area2D_body_entered(body):
	print (global_position)
	if (body.name == "AlexStates"):
		Checkpoint.last_position = global_position
		anim.play("Activated")
		sfx.play()
		cpu_particles_2d.show()
	else:
		cpu_particles_2d.hide()
		anim.play("Not Activated")
		



