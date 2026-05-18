extends Node

var levels = [
	"res://scenes/Main(GrappleTest).tscn",
	"res://scenes/levels/Main(Finished).tscn",
	"res://scenes/levels/(Finished) level0_house.tscn",
	"res://scenes/levels/Outer City.tscn",
	"res://scenes/levels/(Finished)AssemblyPlantsave.tscn",
	"res://scenes/levels/Sewers.tscn",
	"res://Facility.tscn",
	"res://Level 7.tscn",
	"res://Demo End Screen.tscn",
]

var current_level_index = 0

func get_current_level():
	return levels[current_level_index]

func load_next_level():
	current_level_index += 1
	if current_level_index >= levels.size():
		current_level_index = 0  # or end-game scene
	get_tree().change_scene(levels[current_level_index])
	

