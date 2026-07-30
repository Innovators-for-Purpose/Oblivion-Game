extends Sprite

var pulsetime = 0.2
var hackable = null
var hacktool = load("res://scenes/levels/hacktool.tscn").instance()

func _ready():
	add_child(hacktool)
	hacktool.get_node("Area2D").connect("area_entered", self, "_on_Area_area_entered")
	hacktool.get_node("Area2D").connect("area_exited", self, "_on_Area_area_exited")

func _process(_delta):
	if Input.is_action_just_pressed("g") and hackable and not hackable.patience:
		hackable.activate()
		hacktool.get_node("Timer").start()

func _on_pulse_timeout():
	print("timeout")
	hacktool.get_node("Area2D").set_wait_time(pulsetime)

func _on_Area_area_entered(area):
	if area.is_in_group("hackable"):
		hackable = area

func _on_Area_area_exited(_area):
	hackable = null
