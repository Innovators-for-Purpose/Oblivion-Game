extends Area2D

onready var anim = $anim
onready var sfx = $sfx
onready var cpu_particles_2d = $CPUParticles2D




func _on_Area2D_body_entered(body):
	print (global_position)
	if (body.name == "AlexStates"):
		anim.play("Activated")
		sfx.play()
		cpu_particles_2d.show()
		Checkpoint.last_position = global_position
	else:
		anim.play("Not Activated")
#		cpu_particles_2d.hide()



