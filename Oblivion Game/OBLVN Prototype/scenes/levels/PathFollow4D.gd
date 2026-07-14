extends PathFollow2D

var velocity = Vector2(0,0)
var direction = 1
export var speed = 100
#onready var sprite = $"../../BEE BOSS/Sprite"
#
#onready var bee__boss = $"../../BEE BOSS"

func _process(delta):
	set_offset(get_offset() + speed * delta * direction)


