extends KinematicBody2D

var gravity = 10
var velocity = Vector2(0,0)
var speed = 100
var stun = false
export var is_moving_left = true

func _ready():
	$AttackTime.one_shot = true

func _process(_delta):
	if $Anim.animation == "STUNNED":
		return
	move_character()
	detect_turn_around()

func move_character():
	velocity.x = -speed if is_moving_left else speed

	
	
	velocity.y += gravity
	velocity = move_and_slide(velocity, Vector2.UP)
	
func detect_turn_around():
	if not $RayCast2D.is_colliding() and is_on_floor() or $WallDetector.is_colliding():
		is_moving_left = !is_moving_left
		scale.x = -scale.x
		

func hit():
	$AttackPlayer/CollisionShape2D2.set_deferred("disabled",!$AttackPlayer/CollisionShape2D2.disabled)
	$AttackTime.start()

func end_of_hit():
#	$AttackPlayer.monitorable = false
	$AttackPlayer/CollisionShape2D2.set_deferred("disabled",!$AttackPlayer/CollisionShape2D2.disabled)

func start_walk():
	$Anim.play("Walk")


# warning-ignore:unused_argument
func _on_PlayerDetector_body_entered(body):
	if !stun:
		hit()
		$Anim.play("STUNNED")
		$AttackVisual.visible = true
	


func _on_AttackTime_timeout():
	end_of_hit()
	start_walk()
	$AttackVisual.visible = false






func _on_Hurtbox_area_entered(area):
	if area.is_in_group("stun_zap"):
		var timer = get_tree().create_timer(4)
		stun = !stun
		$Anim.play("STUNNED")
		$ShaderAnimate.play("stunned")
		$shockSound.play()
		$AttackPlayer/CollisionShape2D2.set_deferred("disabled",true)
		yield(timer,"timeout")
		stun = !stun
		$AttackPlayer/CollisionShape2D2.set_deferred("disabled",false)
		$ShaderAnimate.play("RESET")
		$Anim.play("Walk")
