extends Node2D
var stop = 1
var array_grap = [PoolVector2Array()]
var pool_array = array_grap[0]
#var pool_array2 = array[1]

func _process(delta):
	if stop == 2 :
		pool_array.append($'../Grappleables'.position)
		pool_array.append($'../Grappleables2'.position)
		pool_array.append($'../Grappleables3'.position)
		array_grap[0] = pool_array
#		array[1] = pool_array2
		print(array_grap[0])
		
		stop = 2





#var player
#var grap_array 
#var grap_pos = [PoolVector2Array()]
#var grap1 = $Grappleables.global_position
#func _process(delta):
#	get_closest_grappable()
#	print(grap_pos)
#func get_closest_grappable():#this should be pretty obvious
#	player = get_tree().get_nodes_in_group("AlexStates")
#	grap_array = [get_tree().get_nodes_in_group("grapple")]
#	grap_pos.push_back()
	
#	print(grapples_positions[0])
#	var point1 = grapples_positions[0].global_position 
#	print(point1)
#	print(grapples_positions[2].global_position)
	
	
	
	
	
	
