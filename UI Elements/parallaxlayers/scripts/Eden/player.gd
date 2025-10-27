extends KinematicBody2D
#
#const GRAVITY = 50
#const WALK_SPEED = 400
#const CROUCH_SPEED = 50
#const RUN_SPEED = 800
#const JUMP_STRENGTH = -900
#const CHAIN_PULL = 105
#const CLIMB_STRENGTH = -450
#
#onready var anim = $Anim
#onready var crouchbox = $Crouch
#onready var standbox = $Stand
#onready var hpBar = $Camera2D/uiSizing/hpBar
#onready var LadderDetect = $LadderDetect
#
#var velocity = Vector2()
#var chain_velocity := Vector2()
#
#var extra_jumps = 1
#var jumps_left = 1
#var is_falling := false
#var midjump := false
#var can_stand := true
#var is_crouching := false
#var is_running := false
#var is_walking := false
#var on_ladder := false
#
##func _input(event: InputEvent) -> void:
##	if event is InputEventMouseButton:
##		if event.pressed:
##			# We clicked the mouse -> shoot()
##			$Chain.shoot(event.position - get_viewport().size * 0.5)
##		else:
##			# We released the mouse -> release()
##			$Chain.release()
#
#func _on_LadderDetect_body_entered(body):
#	on_ladder = true
#
#func _on_LadderDetect_body_exited(body):
#	on_ladder = false
#
#func manage_run(_delta):
#	if Input.is_action_pressed("left"): #run code
#		if Input.is_action_pressed("run"):
#			velocity.x = -RUN_SPEED
#			is_walking = false
#			is_crouching = false
#			is_running = true
#		elif Input.is_action_pressed("crouch") and is_on_floor():
#			velocity.x = -CROUCH_SPEED
#			is_walking = false
#			is_crouching = true
#			is_running = false
#		else:
#			velocity.x = -WALK_SPEED
#			is_walking = true
#			is_crouching = false
#			is_running = false
#	elif Input.is_action_pressed("right"):
#		if Input.is_action_pressed("run"):
#			velocity.x = RUN_SPEED
#			is_walking = false
#			is_crouching = false
#			is_running = true
#		elif Input.is_action_pressed("crouch") and is_on_floor():
#			velocity.x = CROUCH_SPEED
#			is_walking = false
#			is_crouching = true
#			is_running = false
#		else:
#			velocity.x = WALK_SPEED
#			is_walking = true
#			is_crouching = false
#			is_running = false
#	else:
#		velocity.x = 0
#		is_walking = false
#		is_crouching = false
#		is_running = false
#
#func manage_jump(_delta):
#	if is_on_floor(): #gravity
#		velocity.y = 0
#		jumps_left = extra_jumps
#		is_falling = false
#		midjump = false
#	elif on_ladder:
#		if Input.is_action_pressed("jump"):
#			velocity.y = CLIMB_STRENGTH
#		if Input.is_action_pressed("crouch"):
#			velocity.y = -CLIMB_STRENGTH
#	else:
#		velocity.y += GRAVITY
#		is_falling = true
#	if Input.is_action_just_pressed("jump"): #jumps
#		if is_on_floor():
#			velocity.y = JUMP_STRENGTH
#			is_falling = false
#			midjump = true
#		elif jumps_left > 0:
#			velocity.y = JUMP_STRENGTH
#			jumps_left -= 1
#			is_falling = false
#			midjump = true
#
#func manage_hitbox():
#	if is_crouching == true:
#		standbox.disabled = true
#		crouchbox.disabled = false
#	elif can_stand == false:
#		standbox.disabled = true
#		crouchbox.disabled = false
#	else:
#		standbox.disabled = false
#		crouchbox.disabled = true
#	on_ladder = false
#
#func manage_anim(_delta):
##checking direction
#	if velocity.x > 0:
#		anim.flip_h = false
#	if velocity.x < 0:
#		anim.flip_h = true
##all the animation
#	if is_walking:
#		anim.play("run")
#	if is_crouching and velocity.x != 0:
#		anim.play("crouch walk")
#	if is_running:
#		anim.play("run")
#	if is_falling:
#		anim.play("fall")
#	if midjump:
#		anim.play("jump")
#	if velocity.x == 0 and velocity.y == 0:
#		anim.play("idle")
#		if Input.is_action_pressed("crouch"):
#			anim.play("crouch")
#
#func _on_damage_alex_pressed():
#	hpBar.value -= 1
#
#func _on_heal_pressed():
#	hpBar.value += 1
#
#func _on_enemy_input_event(_viewport, _event, _shape_idx):
#	hpBar.value -= 1
#
#func _ready():
#	standbox.disabled = false
#	crouchbox.disabled = true
#
#func _physics_process(delta):
#	manage_run(delta)
#	manage_jump(delta)
#	manage_anim(delta)
#	manage_hitbox()
#
#	if is_falling:
#		print("fall")
#	elif midjump:
#		print ("jumpin")
#	else:
#		print ("chillin")
#	move_and_slide(velocity, Vector2.UP)
#
#	# Hook physics; use this l8r
##	if $Chain.hooked:
##		# `to_local($Chain.tip).normalized()` is the direction that the chain is pulling
##		chain_velocity = to_local($Chain.tip).normalized() * CHAIN_PULL
##		if chain_velocity.y > 0:
##			# Pulling down isn't as strong
##			chain_velocity.y *= 0.55
##		else:
##			# Pulling up is stronger
##			chain_velocity.y *= 1.65
##		if sign(chain_velocity.x) != sign(velocity.x):
##			# if we are trying to walk in a different
##			# direction than the chain is pulling
##			# reduce its pull
##			chain_velocity.x *= 0.7
##	else:
##		# Not hooked -> no chain velocity
##		chain_velocity = Vector2(0,0)
##	velocity += chain_velocity
#
#
#
#
#
#
#
#
