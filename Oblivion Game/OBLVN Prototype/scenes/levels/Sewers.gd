extends Node2D

#
#export(PackedScene) var player_scene
#export(NodePath) var spawn_point_path

func _enter_tree():
	if Checkpoint.last_position:
		$AlexStates.global_position = Checkpoint.last_position
#func _ready():
#	spawn_player()
#
#func spawn_player():
#	var player = player_scene.instance()
#	add_child(player)
#
#	# If a checkpoint exists, use it. Otherwise, use the original Position2D.
#	if Global.current_checkpoint_pos != null:
#		player.global_position = Global.current_checkpoint_pos
#	else:
#		player.global_position = spawn_point.global_position
