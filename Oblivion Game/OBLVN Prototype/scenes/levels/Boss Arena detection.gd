extends Area2D
export var boss_instance : NodePath

func _ready():
# warning-ignore:return_value_discarded
	connect("body_entered",get_node(boss_instance),"init_Boss")


# warning-ignore:unused_argument
func _on_Boss_Arena_detection_body_entered(body):
	set_deferred("monitoring", false)
