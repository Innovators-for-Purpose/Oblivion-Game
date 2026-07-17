extends StaticBody2D

onready var bossgateanim = $"../../Boss Gate/AnimatedSprite"
onready var collision_shape_2d = $"../../Boss Gate/CollisionShape2D"
onready var level__music = $"../Level Music"
onready var bee_boss_music = $"../bee boss music"
onready var bee_death_sfx = $"../Bee death sfx"


func _on_Hitbox_body_entered(body):
	if (body.name == "AlexStates"):
		bee_death_sfx.play()
		queue_free()
	if (body.name == "Stinger"):
		bee_death_sfx.play()
		queue_free()



func _on_Boss_Arena_detection_body_entered(body):
	if  (body.name == "AlexStates"):
		bee_boss_music.play()
		level__music.stop()
	else:
		bee_boss_music.stop()
		level__music.play()
		
