extends Node2D

func _ready():
	print("heal")
	Inventory.remove_item(0)
	
