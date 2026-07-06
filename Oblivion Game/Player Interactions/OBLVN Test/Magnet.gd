extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var player = $KinematicBody2D 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
func _physics_process(delta):
	for v in $Area2D.get_overlapping_bodies():
		if v is KinematicBody2D:
			player = v
			v.magnet_collide_with = self
	if player:
		if player.magnet_collide_with == self and not (player in $Area2D.get_overlapping_bodies()):
			player.magnet_collide_with = null



func _on_Area2D_body_entered(body):
	if body.name == "AlexStates":
		emit_signal("item_pickup", self)
		queue_free()
	print("works")
	pass # Replace with function body.
