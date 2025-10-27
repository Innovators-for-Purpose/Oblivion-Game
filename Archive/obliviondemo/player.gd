extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -510.0
var taser_scene = preload("res://taserweapon.tscn")
var taser_instance


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		if direction == -1:
			GlobalVariables.player_direc = -1
			animated_sprite_2d.flip_h = true
		if direction == 1:
			GlobalVariables.player_direc = 1
			animated_sprite_2d.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
			

	move_and_slide()

#func equip_taser():
	#print ("equipping")
	#if taser_instance != null:
		#taser_instance.queue_free() # Remove existing taser
		#taser_instance = taser_scene.instantiate()
		#$TaserHolder.add_child(taser_instance)
#
#func _on_fire_button_pressed():
	#print ("firing")
	#if taser_instance:
		#print ("firing instance")
		#taser_instance.call("_on_fire_button_pressed") # Or use a signal
