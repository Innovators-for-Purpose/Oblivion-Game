extends Node

var items

func _ready():
	items = read_from_JSON("res://json/itemdata.json")
	for key in items.keys():
		items[key]["key"] = key

func read_from_JSON(path):
	var file = File.new() # <--- In Godot 4, replace 'File' with 'Fileaccess
	if file.file_exists(path): #--------------------------
		file.open(path, File.READ) #______________________ Delete in Godot 4
		var data = parse_json(file.get_as_text()) #-------
		file.close() #                                   | Indent back
		return data #_____________________________________
	else: # Delete
		printerr("Invalid path given") # Delete

func get_item_by_key(key):
	if items and items.has(key):
		return items[key].duplicate(true)
