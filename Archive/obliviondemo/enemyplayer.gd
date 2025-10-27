#extends CharacterBody2D
#@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
##var enemy_speed = -5
#var enemy_speed = -20
#var direction = -1
#
#
#func _process(delta: float) -> void:
	#for i in range(get_slide_collision_count()):
#
		#var collision = get_slide_collision_count()
		#if collision.normal.x != direction:
			#direction *= -1
			#self.scale.x *= -1
			#break
			#
	#position.x += enemy_speed
#
#func _on_body_entered(body: Node2D) -> void:
	#if (body.name == "Player"):
		#animated_sprite_2d.play("killanimation")
		#enemy_speed = 0
		#body.get_node("AnimatedSprite2D").play("deathanimation")
#
	#move_and_slide()	
#
#func _on_character_body_2d_body_entered(body: Node2D) -> void:
	#pass # Replace with function body.
	#
	#move_and_slide()	
	#
	
extends CharacterBody2D  # Or CharacterBody3D for 3D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var speed = 200
var direction = -1  # 1 for right, -1 for left
@export var gravity = 980  # Adjust this value for desired gravity strength
#var velocity = Vector2.ZERO
@export var stun_animation: String = "stun"

var target_position : Vector2
var chasing = false
var target_positionn: Vector2
var move_speed = 100


func _ready():
	var drone = get_parent().get_node("Drone")
	if drone:
		drone.connect("player_detectedd", Callable(self, "_on_drone_player_detectedd"))
		

func _physics_process(delta):
	# Movement
	if not is_on_floor():
		velocity.y += gravity * delta
	velocity.x = speed * direction
	move_and_slide()
	# Wall detection and direction change
	if is_on_wall():
		direction *= -1
		# Optionally flip the sprite for visual feedback
		$AnimatedSprite2D.flip_h = not $AnimatedSprite2D.flip_h  # For 2D, adjust based on your sprite setup
	if target_position != Vector2.ZERO: # Check if a target position is set
		var direction = (target_position - global_position).normalized()
		velocity = direction * move_speed
		move_and_slide()

func _on_player_detectedd(player_position: Vector2):
	target_position = player_position
	# ... logic to initiate movement towards target_position ...


#func _on_body_entered(body: Node2D) -> void:
	#if body.is_in_group("Player"):
		#animated_sprite_2d.play("killanimation")
		#speed = 0
		#body.get_node("AnimatedSprite2D").play("deathanimation")

	# Apply gravity for 3D
	#velocity.y += gravity * delta



#func _on_area_2d_body_entered(body: Node2D) -> void:
	#if body.is_in_group("Player"):
		##if direction == -1:
			##animated_sprite_2d.flip_h = true
		##if direction == 1:
			##animated_sprite_2d.flip_h = false
		#if body.global_position.x < global_position.x:
			#animated_sprite_2d.flip_h = true
		#else:
			#animated_sprite_2d.flip_h = false
		#animated_sprite_2d.play("killanimation")
		#speed = 0
		#body.get_node("AnimatedSprite2D").play("deathanimation")
		#$Timer.start()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		# Face the player
		if body.global_position.x < global_position.x:
			animated_sprite_2d.flip_h = true
		else:
			animated_sprite_2d.flip_h = false

		# Play enemy kill animation
		animated_sprite_2d.play("killanimation")
		speed = 0

		# Play player death animation
		body.get_node("AnimatedSprite2D").play("deathanimation")

		# Start timer (maybe to reset or restart level)
		$Timer.start()

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://main_area.tscn")

func stun(duration: float) -> void:
	# Play stun animation
	animated_sprite_2d.play("stunanimation")
	# Disable movement or actions while stunned
	set_physics_process(false) 
	
	# Timer to end stun
	var timer = get_tree().create_timer(duration)
	await timer.timeout
	set_physics_process(true)
	animated_sprite_2d.play("enemy")
	# Resume animations or actions
	
func _on_drone_player_detectedd(player_position):
	chasing = true
	target_position = player_position
