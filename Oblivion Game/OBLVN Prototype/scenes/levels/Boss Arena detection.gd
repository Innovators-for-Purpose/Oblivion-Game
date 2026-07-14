extends Area2D

func _ready():
	connect("body_entered",get_parent().get_node("BOSS1"),"on_begin")
