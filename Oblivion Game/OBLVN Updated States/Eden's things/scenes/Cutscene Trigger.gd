extends Area2D

var triggered = false
var detected = false

func _on_Cutscene_Trigger_body_entered(body):
	if body.name == "AlexStates" and not triggered and get_node_or_null("DialogNode") == null:
		detected = true

func _process(_delta):
	var alex = get_node("/root/Main2/AlexStates")
	if detected and not triggered:
		if not alex.is_on_floor():
			alex.velocity.y += alex.GRAVITY
			alex.velocity.x = 0
		else:
			get_tree().paused = true
			var dialogue = Dialogic.start("Cutscene")
			dialogue.pause_mode = Node.PAUSE_MODE_PROCESS
			dialogue.connect("timeline_end", self, "unpause")
			add_child(dialogue)
			var anim = get_node("/root/Main2/AlexStates/Anim")
			anim.play("idle")
			triggered = true

func unpause(EndDialogue):
	if EndDialogue:
		get_tree().paused = false
		triggered = true
