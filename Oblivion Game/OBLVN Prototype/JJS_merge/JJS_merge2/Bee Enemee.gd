#tool
extends KinematicBody2D


signal boss_dead
signal init_invincible
export var boss_gate : NodePath
export var boss_trigger : NodePath
onready var flash_shader = preload("res://JJS_merge/JJS_merge2/Flash.tres")
onready var fade_shader = preload("res://JJS_merge/JJS_merge2/fade.tres")
var hurt_finished
var dead = false
var shieldOn = false
var stinger = load("res://JJS_merge/Stinger.tscn")
var invincible = true
onready var target = get_parent().get_node("AlexStates")
var FIRE = false
export var HEALTH = 6
var hold
var grunts = ["res://JJS_merge/sfk/Speech Boss Big Argg.wav","res://JJS_merge/sfk/Speech Boss Small Argg.wav"]

func _ready():
# warning-ignore:return_value_discarded
	# Check if NodePath for Boss Gate Exist
	hide()
	get_parent().get_node("Bee Boss Path/PathFollow2D/RemoteTransform2D").update_position = false
	if boss_gate:
		connect("boss_dead",get_node(boss_gate), "_on_boss_dead")
		print("Boss Gate found!")
	else:
		printerr("No Boss Gate NodePath.")

func init_Boss(body):
	if "AlexStates" in body.name:
		$Sprite.material = fade_shader
		$Sprite.scale = Vector2(0.318,0.375)
		$Sprite.position = Vector2(8,13)
		show()
		get_node(boss_trigger).queue_free()
		$Destory.play()
		$AnimationPlayer.play("Spawn")
		$Sprite.play("summon")
		yield($Sprite,"animation_finished")
		yield(get_tree().create_timer(1),"timeout")
		$Sprite.scale = Vector2(0.139,0.164)
		$Sprite.position = Vector2.ZERO
		$Sprite.material = flash_shader
		Turn_Shield_On()
		get_parent().get_node("Bee Boss Path/PathFollow2D/RemoteTransform2D").update_position = true
		$Sprite.play("idle")

func fire_sting():
	if FIRE:
		var instance = stinger.instance()
#		instance.init(self.scale.x)
		get_parent().add_child(instance)
		instance.global_position = $holder.global_position
		FIRE = false
		$Cooldown.start()

# Detect if player in range.
func _on_Target_Range_body_entered(body):
	if "AlexStates" in body.name:
		$Cooldown.start()

func Hurt():
	HEALTH -= 1
	invincible = true
	$AnimationPlayer.play("HURT")
	$hurtSound.play()
	$arrg.stream = load(grunts[int(rand_range(0,2))])
	$arrg.play()
	yield($arrg,"finished")
	hurt_finished = true
	emit_signal("init_invincible")

func Turn_Shield_On():
	$Shield.play()
	invincible = true
	$forcefield.show()
	$HurtMe.monitoring = false
func Turn_Shield_Off():
	invincible = false
	$forcefield.hide()
	$HurtMe.monitoring = true

func check_death():
	if HEALTH <= 0:
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_CUBIC)
		tween.set_ease(Tween.EASE_OUT)
		dead = true
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
		
	else:
		dead = false

func _on_HurtMe_body_entered(body):
	if "AlexStates" in body.name:
		if !invincible:
				body.velocity.y = -1200
				Hurt()
				check_death()
				yield(self,"init_invincible")
				if !dead:
					Turn_Shield_On()
#				$Invincible.start()
#		$AnimationPlayer.play("IDLE")

func _on_Cooldown_timeout():
	FIRE = true
	fire_sting()

func _on_Die_finished():
	queue_free()

func _physics_process(_delta):
	
#	if $Sprite.animation == "summon":
#		$Sprite.scale = Vector2(0.318,0.375)
#		$Sprite.position = Vector2(8,13)
#	elif $Sprite.animation == "idle":
#		$Sprite.scale = Vector2(0.139,0.164)
#		$Sprite.position = Vector2.ZERO
	$forcefield.frame = $Sprite.frame
	if target:
		if target.position.x >= self.position.x:
			self.scale.x = -1
		else:
			scale.x = 1



func _on_Invincible_timeout():
	hurt_finished = false
	invincible = false
