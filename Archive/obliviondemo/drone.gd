extends CharacterBody2D


@export var speed = 100 
@export var patrol_points: PackedVector2Array = PackedVector2Array([Vector2(0,-582), Vector2(2000,-582)])
@export var detection_range = 150 

var target_position : Vector2
var patrol_index = 0
var player_detected = false
signal player_detectedd(player_position: Vector2)

@onready var ray_cast_2d: RayCast2D = $RayCast2D # Reference to the RayCast2D for Line of Sight check
@onready var player = get_node("res://player.tscn")


func _ready():
	# Ensure there are patrol points before attempting to use them
	if patrol_points.size() == 0:
		# If no patrol points, drone stays still
		target_position = position
		printerr("Warning: patrol_points array is empty! Drone will remain stationary.")
	else:
		target_position = patrol_points[patrol_index]

	
func _physics_process(_delta):
	# If the player is detected, drone chases the player
	if ray_cast_2d.is_colliding():
		var collider = ray_cast_2d.get_collider()
		if (collider is CharacterBody2D):
			chase_player(ray_cast_2d.get_collider())
		else:
			patrol()
	# Otherwise, patrol the defined points
	else:
		patrol()

	move_and_slide()

func patrol():
	target_position = patrol_points[patrol_index]
	# Only execute patrol logic if there are actual patrol points
	if patrol_points.size() > 0:
		# Move towards the current target patrol point
		velocity = position.direction_to(target_position) * speed

		# If the drone is close enough to the current patrol point, move to the next
		if position.distance_to(target_position) < 5:  # Tolerance distance
			patrol_index = (patrol_index + 1) % patrol_points.size()
			target_position = patrol_points[patrol_index]
		
func chase_player(body):
	target_position = body.position
	velocity = position.direction_to(target_position) * speed
	
func _on_body_entered(body: Node2D):
	if body.is_in_group("player"): # Assuming player is in group "player"
		emit_signal("player_detectedd", body.global_position)

#func check_line_of_sight() -> bool:
	#var player_node = get_tree().get_first_node_in_group("Player")
	#if player_node:
		#print ("player")
		#ray_cast_2d.target_position = to_local(player_node.position)  # Target the player
		#ray_cast_2d.force_raycast_update()
		#if ray_cast_2d.is_colliding():
			#print ("LOS")
#
			#var collider = ray_cast_2d.get_collider()
			## If the raycast hits the player, line of sight is clear
			#if collider.is_in_group("player"):
				#return true
	#return false
