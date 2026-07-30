extends Area2D

var dur = 3
var patience = false
onready var anim = get_node("../anim")

func _ready():
	anim.play("default")

func activate():
	anim.play("door slide up")
	patience = true
	yield(get_tree().create_timer(dur), "timeout")
	anim.play("door slide down")
	yield(get_tree().create_timer(1), "timeout")
	patience = false
