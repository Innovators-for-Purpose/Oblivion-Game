extends KinematicBody2D

#Stun gun's variables
var bullet = preload("res://Stun Gun/Stun_Bullets.tscn")
onready var bullet_spawn = $StunGun/Bullet_spawn
var bulletDirection = Vector2(1,0)
onready var can_shoot = true
onready var stun_gun_rotate = $StunGun.rotation

#Player's variables 
var speed = 400
var velocity = Vector2()
var direction = 1
var gravity = 600
var jump_power = -18000

#MOVEMENT INPUT
func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("right") and direction == 1:
		velocity.x += speed
	elif Input.is_action_pressed("right") and direction == -1:
		direction = 1
		$Player_animation.flip_h =! $Player_animation.flip_h
		if speed != 0: 
			$StunGun.flip_h =! $StunGun.flip_h
			bullet_spawn.position.x = 925 
			velocity.x += speed

	if Input.is_action_pressed("left") and direction == 1:
		direction = -1
		$Player_animation.flip_h =! $Player_animation.flip_h
		if speed != 0: 
			$StunGun.flip_h =! $StunGun.flip_h
			bullet_spawn.position.x = -200
			velocity.x -= speed
	elif Input.is_action_pressed("left") and direction == -1:
		velocity.x -= speed

	velocity = velocity.normalized() * speed

#MOVEMENT THROUGHOUT GAME
func _physics_process(_delta):
	get_input()
	if not is_on_floor(): #THIS FIXES problem where player is just sliding by itself at the starting position
		velocity.y += gravity
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_power
	if Input.is_action_pressed("shoot") and can_shoot:
		shoot()
#	_on_Shoot_speed_timeout()
	velocity = move_and_slide(velocity, Vector2.UP)
	
#	if velocity == 0:
#		move_and_collide(velocity)
#	else:
#		velocity = move_and_slide(velocity, Vector2.UP)
	

#Stun gun's function
func shoot():
	
	var bullets = bullet.instance()
	bullets.position = bullet_spawn.global_position
	bullets.rotation = get_node("StunGun").rotation 
	bullets.direction = direction 
	get_tree().current_scene.add_child(bullets)
	
	$Shoot_speed.start()
	can_shoot = false 
	

func _on_Touch_Player_body_entered(body):
	if body.is_in_group("Enemy") and Global.stunned == false:
		speed = 0 
		print(can_shoot)
		$Player_animation.play("death")
		$StunGun.queue_free()
		jump_power = 0
		

func _on_Shoot_speed_timeout():
	if speed > 0: 
		can_shoot = true 
	if speed == 0:
		can_shoot = false 
