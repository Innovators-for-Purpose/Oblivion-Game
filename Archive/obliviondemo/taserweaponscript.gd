extends Node2D 

@export var taser_projectile_scene: PackedScene = preload("res://taserprojectile.tscn")
@export var fire_rate: float = 0.5 # Seconds between shots


@onready var muzzle_position: Marker2D = %Muzzle # Get the muzzle position node
var can_shoot: bool = true

func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fire") and can_shoot:
		shoot()

func shoot() -> void:
	can_shoot = false
	var taser_bolt: Area2D = taser_projectile_scene.instantiate()
	get_parent().add_child(taser_bolt) # Add to parent (e.g., world)
	taser_bolt.global_transform = muzzle_position.global_transform # Position at muzzle
	# Set the taser bolt's direction based on the taser's rotation
	taser_bolt.rotation = global_rotation
	
	# Timer to control fire rate
	var timer = get_tree().create_timer(fire_rate)
	await timer.timeout
	can_shoot = true
	
	#var raw_direction = global_position - global_position
	#var direction = Vector2(abs(raw_direction.x), raw_direction.y)
	#var angle
	#if (direction > 0):
		#angle = direction.angle()
	#else:
		#angle = -direction.angle()
		
func _physics_process(_delta: float) -> void:
	if GlobalVariables.player_direc == 1:
		$Sprite2D.flip_h =! $Sprite2D.flip_h
		
		

	
