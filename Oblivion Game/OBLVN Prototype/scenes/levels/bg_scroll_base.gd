extends ParallaxBackground

export var speed_y = 90.0
export var speed_x = 56.0

func _process(delta):
	scroll_base_offset.y += speed_y * delta
	scroll_base_offset.x += speed_x * delta
