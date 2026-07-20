extends Area2D

var tween_dur = 0.7
var transmode = Tween.TRANS_QUINT
var easemode = Tween.EASE_IN_OUT

var active = false
var happened = false
var entered = false
var exited = false
onready var alex = get_node("/root/level/AlexStates")
onready var cam = get_node("/root/level/AlexStates/Camera2D")
onready var t1 = get_node("../AlexStates/Camera2D/T1") #Zoom in
onready var t2 = get_node("../AlexStates/Camera2D/T2")

func _ready():
	connect("body_entered", self, "on_NPC_body_entered")
	connect("body_exited", self, "on_NPC_body_exited")
	$Icon.visible = false

func _input(event):
	if (get_node_or_null("DialogNode") == null
		and event.is_action_pressed("chat")
		and active
		and alex.state == alex.States.FLOOR):
			
			var place = self.get_global_position() #Where is the cutscene node
			t1.interpolate_property(cam, "zoom",
				cam.target_zoom, cam.event_zoom, tween_dur,
				transmode, easemode, 0)
			t2.interpolate_property(cam, "global_position",
				alex.get_global_position(), place, tween_dur,
				transmode, easemode, 0)
			t1.start()
			t2.start()
			yield(get_tree().create_timer(tween_dur), "timeout") #DO NOT TOUCH THIS UNLESS YOU WANT THE ZOOM TO BREAK
			get_tree().paused = true
			if happened:
				var dialogue = Dialogic.start("Game Dialogue 2")
				dialogue.pause_mode = Node.PAUSE_MODE_PROCESS
				dialogue.connect("timeline_end", self, "unpause")
				add_child(dialogue)
			else:
				var dialogue = Dialogic.start("short dialogue 1")
				dialogue.pause_mode = Node.PAUSE_MODE_PROCESS
				dialogue.connect("timeline_end", self, "unpause")
				add_child(dialogue)
				
				
			var anim = get_node("/root/level/AlexStates/Anim")
			anim.play("Final Idle")
			face_Alex()
	pass

func face_Alex():
	print("Alex pos x = " + String(alex.position.x))
	print("Avery pos x = " + String($Avery.global_position.x))
	print("Theo pos x = " + String($Theo.global_position.x))
	if alex.position.x < $Avery.global_position.x:
		print("huh")
		$Avery.set_flip_h(true)
	if alex.position.x < $Theo.global_position.x:
		$Theo.set_flip_h(true)
		print("TURN ALREADY!!!")

func unpause(EndDialogue):
	if EndDialogue:
		
#		alex.move_and_collide(Vector2(0,0))
#		cam.set_pause_mode(false)
		happened = true
		$Avery.set_flip_h(false)
		$Theo.set_flip_h(false)
		t1.interpolate_property(cam, "zoom",
			cam.event_zoom, cam.target_zoom, tween_dur,
			transmode, easemode, 0)
		t2.interpolate_property(cam, "global_position",
			self.get_global_position(), alex.get_global_position(), tween_dur,
			transmode, easemode, 0)
		t1.start()
		t2.start()
		cam.set_pause_mode(2)
		yield(get_tree().create_timer(tween_dur), "timeout")
		get_tree().paused = false
		cam.set_pause_mode(0)
#		cam.set_global_position(get_node("/root/Main2/AlexStates").get_global_position())

func on_NPC_body_entered(body):
	if body.name == "AlexStates":
		active = true
		entered = true
		exited = false

func on_NPC_body_exited(body):
	if body.name == "AlexStates":
		active = false
		entered = false
		exited = true

func _process(_delta):
	if entered:
		$Icon.visible = true
		if happened:
			$Icon.play("2 in")
			if $Icon.get_frame() == 3:
				$Icon.stop()
		else:
			$Icon.play("1 in")
			if $Icon.get_frame() == 3:
				$Icon.stop()
	if exited:
		if happened:
			$Icon.play("2 out")
			if $Icon.get_frame() == 3:
				$Icon.stop()
				$Icon.visible = false
		else:
			$Icon.play("1 out")
			if $Icon.get_frame() == 3:
				$Icon.stop()
				$Icon.visible = false
	
#	if not active:
#		$Icon.stop()
