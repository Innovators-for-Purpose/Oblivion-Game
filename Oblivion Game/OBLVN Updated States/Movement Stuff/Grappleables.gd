extends Node2D

#var grap = []


func _ready():
	$grappleCross.hide()
	
#	for child in get_parent().get_children():
#		if child.name.begins_with("Grappleable"):
#			child.add_to_group("grapple")
#
#	grap = get_tree().get_nodes_in_group("grapple")
#
#	if position == get_closest_grappable():
#		$grappleCross.visible = true


func enable_cross(enable: bool) -> void:
	if enable:
		$grappleCross.show()
		$grappleCross.global_position = global_position
	else:
		$grappleCross.hide()
#if has_node("grappleCross"):
#		var g = $grappleCross
#		if enable:
#			g.show
#			g.global_position = global_position
#		else:
#			g.hide()


#func get_closest_grappable():#this should be pretty obvious
#	var closest = null
#	var closest_dist = INF
#
#	for g in grap:
#		var dist = self.global_position.distance_to(g.global_position)
#
#		if dist < closest_dist:
#			closest_dist = dist
#			closest = g
#
#	return closest
