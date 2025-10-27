extends KinematicBody2D

export (int) var speed = 340
export (int) var jump_speed = -900
export (int) var gravity = 2820
export (float) var zoom_amt = 1.0
var velocity = Vector2.ZERO

func _ready():
	$DemoCam.zoom = Vector2(zoom_amt,zoom_amt)


func get_input():
	velocity.x = 0
	if Input.is_action_pressed("right"):
		$Sprite.play("walk_R")
		velocity.x += speed
	if Input.is_action_pressed("left"):
		$Sprite.play("walk_L")
		velocity.x -= speed
	if Input.is_action_just_pressed("RETURN") and OS.is_debug_build():
		get_tree().change_scene("res://scenes/levels/Level0.tscn")

func animate():
	if velocity != Vector2.ZERO:
		$Sprite.playing = true
	else:
		$Sprite.playing = false

	if Input.is_action_pressed("right"):
		$Sprite.play("walk_R")
	elif Input.is_action_pressed("left"):
		$Sprite.play("walk_L")
	else:
		$Sprite.frame = 0

func _physics_process(delta):
	get_input()
	animate()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_speed

func zoom_amount(x,y):
	var tween = get_tree().create_tween()
	tween.tween_property($DemoCam, "zoom", Vector2(x,y), 1.2)
