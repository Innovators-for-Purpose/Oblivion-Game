extends Area2D
onready var sprite = $"../Sprite"
onready var sfx = $"../AudioStreamPlayer"

var dur = 3
var patience = false
onready var anim = get_node("../anim")

func _ready():
	anim.play("default")
	sprite.play("red")

func activate():
	sfx.play()
	anim.play("door slide up")
	sprite.play("green")
	patience = true
	yield(get_tree().create_timer(dur), "timeout")
	anim.play("door slide down")
	yield(get_tree().create_timer(1), "timeout")
	sprite.play("red")
	patience = false
