extends Area2D

onready var sfx = $sfx
onready var collision = $CollisionShape2D
onready var sprite = $Sprite
onready var particles = $Particles
onready var collectablemanager = $"%collectablemanager"

func _ready():
	randomize() 

func _on_MicroChip_body_entered(body):
	if (body.name == "AlexStates"):
		sprite.visible = false
		collision.set_deferred("disabled", true)
		particles.emitting = true
		sfx.pitch_scale = rand_range(0.8, 1.2)
		collectablemanager.add_point()
		sfx.play()
		yield(sfx, "finished")
		queue_free()


func play_random_pitch_sound():
	sfx.pitch_scale = rand_range(0.95, 1.03)
	sfx.play()
