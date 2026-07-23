extends ParallaxBackground



export(float) var scroll_speed = 100.0

func _process(delta):
	scroll_base_offset.x -= scroll_speed * delta
