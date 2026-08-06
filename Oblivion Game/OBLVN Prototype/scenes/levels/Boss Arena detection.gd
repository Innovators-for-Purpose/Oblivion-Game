extends Area2D

export var boss_instance : NodePath


# Called when the node enters the scene tree for the first time.
func _ready():
# warning-ignore:return_value_discarded
	connect("body_entered",get_node(boss_instance),"init_Boss")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


# warning-ignore:unused_argument
