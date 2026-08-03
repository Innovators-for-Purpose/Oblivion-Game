extends KinematicBody2D

const SPEED = 350
const KNOCKBACK = -1000
const ATTENTION = 15
const STUNNED = 5
const GRAVITY = 500

var target = null
var velocity := Vector2()

enum States {IDLE = 1, CHASE, RETREAT, STUN}
var state = States.IDLE

onready var stunTime = $stunned
onready var attackTime = $patience
onready var anim = $Anim


#	**CUSTOM FUNCTIONS**
func _ready():
	attackTime.set_wait_time(ATTENTION)
	stunTime.set_wait_time(STUNNED)
	
	$Sightline.set_deferred('monitoring', true)

func move_chase():
	if target.global_position.x > self.global_position.x:
		velocity.x += 0.1
	if target.global_position.x < self.global_position.x:
		velocity.x -= 0.1

func move_stop(rate):
	velocity.x = move_toward(velocity.x, 0, lerp(rate, 0, 0.3))
#	velocity.x = move_toward(velocity.x, 0, ease(rate, 0.8))

func move_retreat():
#	var jumpback = 1
	if target.global_position.x > self.global_position.x:
		velocity.x = -1
	if target.global_position.x < self.global_position.x:
		velocity.x = 1

func cap_velocity():
	if not state == States.RETREAT:
		if velocity.x > 1:
			velocity.x = 1
		if velocity.x < -1:
			velocity.x = -1
		if velocity.y > 2:
			velocity.y = 2

func fall():
	if is_on_floor():
		velocity.y = 0
	else:
		velocity.y += 0.5

func animate():
	if velocity.x > 0:
		anim.set_flip_h(true)
	elif velocity.x < 0:
		anim.set_flip_h(false)


#	**PROCESSES**
func _process(_delta):
#	print("velocity: ", velocity.x)
	pass

func _physics_process(_delta): #state machine here!
#	if not $Sightline.is_monitoring() and $Sightline/CollisionShape2D.is_disabled():
#		print("we did it!!!")
	match state:
		States.IDLE:
			if velocity.x != 0:
				move_stop(0.02)
			anim.play("idle")
			animate()
		States.CHASE:
			move_chase()
			anim.play("chase")
			animate()
		States.RETREAT:
			move_stop(0.03)
			if velocity.x == 0:
				state = States.CHASE
				$Hurtbox/CollisionShape2D.set_disabled(false)
			anim.play("chase")
			
		States.STUN:
			velocity.x = 0
			anim.play("stun")
			animate()
	
	fall()
	cap_velocity()
	move_and_slide_with_snap(Vector2(velocity.x * SPEED, velocity.y * GRAVITY), Vector2(0, 1))


#	**SIGNALS**
func _on_Hurtbox_body_entered(body): #the one that stuns the rat
	if body.name == "AlexStates":
		if body.velocity.x > 0:
			print("got stunned...")
			stunTime.set_wait_time(STUNNED)
			stunTime.start()
			$hitbox.set_deferred('monitoring', false)
			$Sightline.set_deferred('monitoring', false)
			state = States.STUN
			body.velocity.y = KNOCKBACK
		else:
			print("not falling")
#		print("stunned")

func _on_Sightline_body_entered(body):
	if body.name == "AlexStates":
		state = States.CHASE
		target = body
		attackTime.stop()
		attackTime.set_wait_time(ATTENTION)
#		print("spotted him")

func _on_Sightline_body_exited(_body):
	attackTime.start()
#	print('out of sight')

func _on_Timer_timeout():
	state = States.IDLE
	target = null
#	print("idling")

func _on_stunned_timeout():
	stunTime.set_wait_time(STUNNED)
	$Sightline.set_deferred('monitoring', true)
	$hitbox.set_deferred('monitoring', true)
	if target:
		velocity = Vector2(0,0)
		state = States.CHASE
#		print("stun to CHASE")
	else:
		state = States.IDLE
#		print("stun to IDLE")


func _on_hitbox_area_entered(area): #the one that hurts Alex
	if area.name == "Area2D":
		if area.get_parent().velocity.y <= 0:
			print("hit him!!!!")
			$Hurtbox/CollisionShape2D.set_deferred("disabled", true)
			move_retreat()
	#		print("velocity: ", velocity.x)
			state = States.RETREAT
		else:
			print("can't hit, moving down")
			pass
