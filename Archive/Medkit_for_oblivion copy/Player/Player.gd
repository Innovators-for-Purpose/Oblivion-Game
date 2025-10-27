extends KinematicBody2D

var speed = 200
var velocity
var direction = 1
const GRAVITY = 400
var jump_ability = -7000
var moving = false
var health = 100
var heal = false
onready var hpBar = $CanvasLayer/hpBar

func _ready():
	hpBar.value = 5

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("right") and direction == 1:
		moving = true
		velocity.x += speed 
	elif Input.is_action_pressed("right") and direction == -1:
		moving = true
		direction = 1
		$Player_anim.flip_h =! $Player_anim.flip_h 
		velocity.x += speed
	if Input.is_action_pressed("left") and direction == 1:
		moving = true
		direction = -1
		$Player_anim.flip_h =! $Player_anim.flip_h 
		velocity.x -= speed 
	elif Input.is_action_pressed("left") and direction == -1:
		moving = true
		velocity.x -= speed 
	
func _physics_process(delta):
	get_input()
	velocity.y += GRAVITY
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_ability
	if velocity == Vector2.ZERO:
		moving = false
	if moving == true and heal == false and health > 0:
		$Player_anim.play("walk")
	elif moving == false and heal == false:
		$Player_anim.play("idle")	
#	get_input()
#	velocity.y += GRAVITY
#	if Input.is_action_pressed("jump") and is_on_floor():
#		velocity.y = jump_ability

	if health == 0:
		$Timer.start(5.0)
		$Player_anim.play("death")
		print("NOOOOOOOO")
	velocity = move_and_slide(velocity, Vector2.UP)

func _on_Player_Area_area_entered(area):
	if area.is_in_group("Heal"):
		heal = true
		print("Player grabbed healing potion")
		$Player_anim.play("power-up")
		if 20 + health < 100:
			health += 20
			hpBar.value += 1
			print("Player health: ", health)
		else:
			health = 100
			print("Player health: ", health)
		$Timer.start()

func _on_Player_Area_body_entered(body):
	if body.is_in_group("Enemy"):
		health -= 20
		hpBar.value -= 1

func _on_Timer_timeout():
	heal = false 

