extends Node

var levels = [
	"res://menus/Node2D.tscn",
	"res://scenes/Main(GrappleTest).tscn",
	"res://scenes/levels/Main(Finished).tscn",
	"res://scenes/levels/(Finished) level0_house.tscn",
	"res://scenes/levels/Outer City.tscn",
	"res://scenes/levels/(Finished)AssemblyPlantsave.tscn",
	"res://scenes/levels/Sewers.tscn",
	"res://SewerBase.tscn",
	"res://Facility.tscn",
	"res://Level 7.tscn",
	"res://Demo End Screen.tscn",
]



var current_level_index = 1

func get_current_level():
	return levels[current_level_index]

func load_next_level():
	current_level_index += 1
	if current_level_index >= levels.size():
		current_level_index = 0  # or end-game scene
	get_tree().change_scene(levels[current_level_index])
	
func reset_global_position():
	# Resets the current node's global position to the world center (0,0)
	$AlexStates.global_position = Vector2(0, 0)
#	$Position2D.global_position = $AlexStates.global_position
	

		 
