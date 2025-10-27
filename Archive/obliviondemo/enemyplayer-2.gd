extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var gravity = 980
@export var patrol_speed = 100
@export var chase_speed = 150

var direction := -1
var chasing := false
var target_position := Vector2.ZERO


func _ready():
	var drone = get_parent().get_node("Drone")
	if drone:
		drone.connect("player_detected", Callable(self, "_on_drone_player_detected"))


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if chasing:
		var to_target = (target_position - global_position).normalized()
		velocity.x = to_target.x * chase_speed
		animated_sprite_2d.flip_h = velocity.x < 0
	else:
		velocity.x = patrol_speed * direction
		if is_on_wall():
			direction *= -1
			animated_sprite_2d.flip_h = direction < 0


	move_and_slide()

func _on_drone_player_detected(player_position: Vector2):
	chasing = true
	target_position = player_position

func stun(duration: float) -> void:
	animated_sprite_2d.play("stunanimation")
	set_physics_process(false)
	var timer = get_tree().create_timer(duration)
	await timer.timeout
	set_physics_process(true)
	animated_sprite_2d.play("enemy")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		animated_sprite_2d.play("killanimation")
		velocity = Vector2.ZERO
		body.get_node("AnimatedSprite2D").play("deathanimation")
		$Timer.start()

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://main_area.tscn")
