extends KinematicBody2D

var gravity = 10
var velocity = Vector2(0,0)

var speed = 100

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
	if not $RayCast2D.is_colliding() and is_on_floor():
		is_moving_left = !is_moving_left
		scale.x = -scale.x
		

func hit():
	$AttackPlayer.monitoring = true
	$AttackTime.start()

func end_of_hit():
	$AttackPlayer.monitoring = false

func start_walk():
	$Anim.play("Walk")


# warning-ignore:unused_argument
func _on_PlayerDetector_body_entered(body):
	$Anim.play("ATTACK")
	hit()
	$AttackVisual.visible = true
	


func _on_AttackTime_timeout():
	end_of_hit()
	start_walk()
	$AttackVisual.visible = false






func _on_Hurtbox_area_entered(area):
	if area.is_in_group("stun_zap"):
		$Anim.play("STUNNED")
