extends Button


export var hover_scale : Vector2 = Vector2(1.1, 1.1)
export var default_scale : Vector2 = Vector2(1.0, 1.0)
export var transition_time : float = 0.1

onready var tween = Tween.new()

func _ready():
	add_child(tween)
	rect_pivot_offset = rect_size / 2

func _on_Button11_mouse_entered():
	_scale_button(hover_scale)

func _on_Button11_mouse_exited():
	_scale_button(default_scale)

func _scale_button(target_scale: Vector2):
	tween.remove_all()
	tween.interpolate_property(
		self, 
		"rect_scale", 
		rect_scale, 
		target_scale, 
		transition_time, 
		Tween.TRANS_QUAD, 
		Tween.EASE_OUT
	)
	tween.start()
