extends Node2D

#
#export var player_scene: PackedScene
#export var spawn_point: $Position2D

func _enter_tree():
	if Checkpoint.last_position:
		$AlexStates.global_position = Checkpoint.last_position

#
#func _ready():
#	spawn_player()
#
#func spawn_player():
#	var player = player_scene.instantiate()
#	# Add the player to the scene tree FIRST
#	add_child(player)
#	# Set the global position AFTER adding to the tree to prevent teleport glitches
#	player.global_position = spawn_point.global_position



onready var spawn_point = $Position2D
var object_to_spawn = preload("res://Movement Stuff/AlexStates.tscn")

func spawn_object():
	var new_object = object_to_spawn.instantiate()
	new_object.global_position = spawn_point.global_position
	add_child(new_object)

