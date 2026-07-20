extends Camera2D

export var zoom_speed: float = 4.0
var target_zoom: Vector2 = Vector2(1, 1)

func _ready():
	current = true

func _physics_process(_delta):
	set_zoom(target_zoom)
