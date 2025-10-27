extends Area2D

onready var player = get_node("../Player")

func _ready():
# warning-ignore:return_value_discarded
	connect("area_entered",player,"_on_MouseDetect_area_entered")
# warning-ignore:return_value_discarded
	connect("area_exited",player,"_on_MouseDetect_area_exited")

func _physics_process(_delta):
	position = get_global_mouse_position()
