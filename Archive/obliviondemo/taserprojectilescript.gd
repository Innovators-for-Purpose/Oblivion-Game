extends Area2D 

@export var speed: float = 500.0
@export var stun_duration: float = 1.0 # Duration in seconds
var direction = 1

func _ready():
	if GlobalVariables.player_direc == -1:
		direction = -1

func _physics_process(delta: float) -> void:
	# Move the taser bolt forward
	position += transform.x * speed * delta * direction

func _on_body_entered(body: Node2D) -> void:
	# Check if the collided body is an enemy
	if body.is_in_group("enemy"): # Ensure enemies are in this group
		body.stun(stun_duration) # Assuming enemies have a 'stun' method
		queue_free() # Remove the taser bolt after collision

#func _on_area_entered(area: Area2D) -> void:
	## If the taser bolt enters another Area2D, check for stun functionality
	#if area.is_in_group("enemyplayer"):
		#area.get_parent().stun(stun_duration)
	#queue_free()
	
	
