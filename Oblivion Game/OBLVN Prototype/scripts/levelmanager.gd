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
		current_level_index = 1  # or end-game scene
	get_tree().change_scene(levels[current_level_index])

func on_level_loaded():
	var current_scene = get_tree().current_scene
	if not current_scene:
		return
	var spawn_point = current_scene.find_node("Position2D", true, false)
	var player = current_scene.find_node("AlexStates", true, false)
	if spawn_point and player:
		player.global_position = spawn_point.global_position
	
	

