extends Node2D
onready var player = get_node("..")
onready var magtiles = get_node('/root/Main/MagTiles')
#onready var velocity = $
var LR = true
var colide = false
func _physics_process(delta):
	var current_vel = player.velocity.x
	
	var jump = player.velocity.y
	if colide == false:
		if LR == true:
			rotation_degrees = -90
			position.x = -10
		else:
			rotation_degrees = 90
			position.x = 10
		if current_vel >= 1:
			LR = false
		elif current_vel <= -1:
			LR = true
		elif jump <= -1 :
			rotation_degrees = 0
		
	print(colide)



func _on_Area2D_area_entered(area):
	if is_in_group('mag'):
		colide = true
		
#		player.position = lerp(player.velocity, magtiles.position, 10 )
		player.position = player.position.linear_interpolate(magtiles.position, 0.1)


func _on_Area2D_area_exited(area):
	
	colide = false
