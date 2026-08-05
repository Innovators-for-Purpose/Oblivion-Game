extends Position2D

export var EnemyInstance : PackedScene
var isVisible = false
var Enemy_InstanceActive = false
var SpawnTime = true
signal EnemySpawned
var re_enter = true

func OnEnemyLeave():
	Enemy_InstanceActive = false
	re_enter = false
	


func _ready():
	if EnemyInstance:
		print("Instance Found: " + EnemyInstance.resource_name)

func checkSpawnCondition():
	if !Enemy_InstanceActive and isVisible and re_enter:
		re_enter = false
		spawnEnemy()


func _on_VisibilityNotifier2D_screen_entered():
	if !re_enter:
		re_enter = true
	isVisible = true

func spawnEnemy():
	Enemy_InstanceActive = true
	var ene = EnemyInstance.instance()
	ene.global_position = global_position
	ene.connect("tree_exited",self,"OnEnemyLeave")
	get_parent().add_child(ene)
	emit_signal("EnemySpawned")

func _on_VisibilityNotifier2D_screen_exited():

	isVisible = false

func _process(_delta):
	checkSpawnCondition()
