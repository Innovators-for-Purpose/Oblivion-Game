extends KinematicBody2D


signal boss_dead
export var stinger : PackedScene
var invincible = false
onready var target = get_parent().get_node("AlexStates")
var FIRE = false
var HEALTH = 6
var hold
var grunts = ["res://JJS_merge/sfk/Speech Boss Big Argg.wav","res://JJS_merge/sfk/Speech Boss Small Argg.wav"]

func _ready():
# warning-ignore:return_value_discarded
	$Destory.play()
	connect("boss_dead",get_parent().get_node("Boss Gate"), "_on_boss_dead")

#	$AnimationPlayer.play("RESET")




#func _on_Area2D_body_entered(body):
#	if (body.name == "AlexStates"):
##			anim.play("hit")
#			queue_free()


func fire_sting():
	if FIRE:
		var instance = stinger.instance()
#		instance.init(self.scale.x)
		get_parent().add_child(instance)
		instance.global_position = $holder.global_position
		FIRE = false
		$Cooldown.start()


func _on_Target_Range_body_entered(body):
	if "AlexStates" in body.name:
		$Cooldown.start()

func Hurt():
	HEALTH -= 1
	$AnimationPlayer.play("HURT")
	$hurtSound.play()
	$arrg.stream = load(grunts[int(rand_range(0,2))])
	$arrg.play()

func _on_HurtMe_body_entered(body):
	if "AlexStates" in body.name:
		if !invincible:
			body.velocity.y = -1200
			Hurt()
			invincible = true
			$Invincible.start()
		if HEALTH <= 0:
			var tween = create_tween()
			tween.set_trans(Tween.TRANS_CUBIC)
			tween.set_ease(Tween.EASE_OUT)
			get_parent().get_node("Bee Boss Path/PathFollow2D/RemoteTransform2D").update_position = false
			$TargetRange.monitoring = false
			$Cooldown.stop()
			$forcefield.hide()
			invincible = true
			$AnimationPlayer.play("Dying")
			tween.tween_property($Sprite.material,"shader_param/flash_value",1.0, 2)
			yield(tween,"finished")
			emit_signal("boss_dead")
			$Sprite.hide()
			$BOOM.emitting = true
			$Die.play()
#		$AnimationPlayer.play("IDLE")

func _on_Cooldown_timeout():
	FIRE = true
	fire_sting()

func _on_Die_finished():
	queue_free()

func _physics_process(_delta):
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_OUT)
	if invincible and !(HEALTH <= 0):
		$forcefield.show()
		tween.tween_property($forcefield,"modulate:a", 50.0, 2)
		$HurtMe.monitoring = false
	else:
		$forcefield.hide()
		tween.tween_property($forcefield,"modulate:a", 0.0, 2)
		$HurtMe.monitoring = true

	
	if target:
		if target.position.x >= self.position.x:
			self.scale.x = -1
		else:
			scale.x =1
#		print(self.scale.x)



func _on_Invincible_timeout():
	invincible = false
