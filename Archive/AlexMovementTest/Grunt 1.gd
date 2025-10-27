extends KinematicBody2D

const RUN_SPEED = 200
const JUMP_HEIGHT = -1400
const GRAVITY = 300

onready var alex = $Alex_Template

var velocity = Vector2()

func _on_Area2D_body_entered(body):
	if bxsody = alex:
		return true
	return false

func _physics_process(delta):
	pass


