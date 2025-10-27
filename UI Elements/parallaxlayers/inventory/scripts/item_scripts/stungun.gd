extends Node2D

var ammo = 10

var gun_item

func _ready():
	for item in Inventory.items:
		if item and item.key == "stun_gun":
			gun_item = Inventory.items.find(item)
			return




func _physics_process(_delta):
	look_at(get_global_mouse_position())
	if ammo < 1:
		Inventory.remove_item(gun_item)
		queue_free()
		

func _input(event):
	if event.is_action_pressed("click"):
		if ammo > 0:
			fire()
			ammo -= 1

func fire():
	var bllt = preload("res://inventory/scenes/projectiles/zapzap.tscn")
	var instance = bllt.instance()
	instance.position = global_position
	instance.transform = global_transform
	get_parent().get_parent().add_child(instance)
