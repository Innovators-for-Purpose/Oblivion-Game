extends KinematicBody2D

enum States {FLOOR = 1, AIR, GRAPPLE, LADDER, DAMAGE}
var state = States.FLOOR

var hit = false
var dp

const GRAVITY = 50
const WALK_SPEED = 250
const CROUCH_SPEED = 100
const RUN_SPEED = 600
const JUMP_STRENGTH = -900
const CHAIN_PULL = 600
const CLIMB_STRENGTH = -350
const GRAPPLE_RADIUS = 60
const MAX = 45
const MIN = 0
export var MAX_HEALTH = 100
export var inertia = 100
var HP

onready var AudioMng = AudioStreamPlayer.new()

onready var hurtSound = load("res://Music and SFX/plyrHurt.wav")
onready var lowHP = AudioStreamPlayer.new()

onready var anim = $Anim
onready var crouchbox = $Short
onready var standbox = $Tall
onready var hpBar = $CanvasLayer/Sizing/hpBar
onready var LadderDetect = $LadderDetect
onready var Chain = $Chain
onready var CoyoteTime = $Coyote
#onready var grap:Array = [$'../Grappleables'.global_position,$'../Grappleables2'.global_position,$'../Grappleables3'.global_position]
var grap = []

var djump := true
var can_djump := true
var on_ladder := false
var can_grapple := false
var hook_position := Vector2()
var coyote := false
var velocity = Vector2()
var chain_velocity := Vector2()
var mouse
var graple = 0
var location = Vector2(0,0)
var array_grap = [PoolVector2Array()]
var pool_array = array_grap[0]
#var player = self.global_position
var stop = 1


func _ready():
	CoyoteTime.set_wait_time(.5)
	
	for child in get_parent().get_children():
		if child.name.begins_with("Grappleable"):
			child.add_to_group("grapple")
	
	grap = get_tree().get_nodes_in_group("grapple")
	
	HP = MAX_HEALTH
	
	hpBar.value = HP
	lowHP.stream = load("res://Music and SFX/lowHp.wav")
	lowHP.name = "LowHP"
	lowHP.autoplay = true
	lowHP.connect("finished",self,"remove_lowHP")
	
	add_child(AudioMng)
	
	
func _on_Area2D_area_entered(area):

	if area.is_in_group("grapple"):
		stop = 1

	if "Spikes" in area.get_parent().name:
		state = States.DAMAGE
		dp = 10
	if "Acid" in area.get_parent().name:
		state = States.DAMAGE
		dp = 15
	if "BOBM" in area.get_parent().name:
		state = States.DAMAGE
		dp = 100000000000000
	if "AttackPlayer" in area.name:
		state = States.DAMAGE
		dp = 30
	if "Heal" in area.get_parent().name:
		if HP < MAX_HEALTH:
			HP += 20
		else:
			pass
	if "stinger" in area.get_parent().name:
		state = States.DAMAGE
		dp = 30
#	var target = null
#	if area.has_method("enable_cross"):
#		target = area
#	elif area.get_parent() and area.get_parent().has_method("enable_cross"):
#		target = area.get_parent() 
#	elif area.get_parent() and area.get_parent().has_method("enable_cross") and area.get_parent().get_parent().has_method("enable_cross"):
#			target = area.get_parent().get_parent()
func _on_Area2D_area_exited(area):
	if area.is_in_group("grapple"):
		
		stop = 2
		can_grapple = false
	if "Spike" in area.name:
		state = States.FLOOR
#	var target = null
#	if area.has_method("enable_cross"):
#		target = area
#	elif area.get_parent() and area.get_parent().has_method("enable_cross"):
#		target = area.get_parent() 
#	elif area.get_parent() and area.get_parent().has_method("enable_cross") and area.get_parent().get_parent().has_method("enable_cross"):
#			target = area.get_parent().get_parent()
#	if target:
#		target.call("enable_cross", false)

func get_closest_grappable():#this should be pretty obvious
	var closest = null
	var closest_dist = INF
	
#	for g in grap:
	for g in get_tree().get_nodes_in_group('grapple'):
		var dist = self.global_position.distance_to(g.global_position)
		
		if dist < closest_dist:
			closest_dist = dist
			closest = g
			
		
	return closest
#	closest.get_child('grappleCross').visable = true
	
	

func remove_lowHP():
	get_node("LowHP").queue_free()
	lowHP = AudioStreamPlayer.new()
	lowHP.stream = load("res://Music and SFX/lowHp.wav")
	lowHP.name = "LowHP"
	lowHP.autoplay = true
	lowHP.connect("finished",self,"remove_lowHP")

# warning-ignore:unused_argument
func _input(event: InputEvent):#the commented code ether makes grapple mouse controled 
	#or makes the grapple need to have the grapple hook out
#	$GrappleLineDetect.set_cast_to(get_tree().call_group("grapple","location"))
	if (Input.is_action_just_pressed("grapple") and can_grapple == true and !get_node_or_null("stun_gun")):
		
#	and event.pressed
#	and can_grapple
#	and not $GrappleLineDetect.is_colliding()
#	and Inventory.selected == 3): add this for grapple pick up
		mouse = get_global_mouse_position()
#		for grappleable in get_tree().get_nodes_in_group("grapple"):
#			var dist = global_position.distance_to(grappleable.global_position)
#			if dist < MIN or dist > MAX:
#				$Chain.release()
#				print("release()")
#				return
#			else:
#				$Chain.shoot(location - self.global_position)
#if hook_position.x + GRAPPLE_RADIUS >= mouse.x and hook_position.x - GRAPPLE_RADIUS <= mouse.x and hook_position.y + GRAPPLE_RADIUS >= mouse.y and hook_position.y - GRAPPLE_RADIUS <= mouse.y:
#			print ('yay')
		
		$Chain.shoot(location - self.global_position)
#		print("location = ",location)
		print ("hook position = ", hook_position)
#		print ("mouse position = ", mouse)
		return true
#	elif not get_tree().get_nodes_in_group("grapple") and CollisionShape2D:
#		$Chain.release()
		
	else:
		$Chain.release()
		return false

func _physics_process(_delta):
	if stop == 1:
		can_grapple = true
		var closest = get_closest_grappable()
		if closest:
			location = closest.global_position
			hook_position = location
		else:
			can_grapple = false
			stop = 2
#		$CanvasLayer/grappleCross.visible = false
	if stop == 2 :
		can_grapple = false
		$grap_area.monitoring = false
		$grap_area.monitoring = true
	for g in get_tree().get_nodes_in_group('grapple'):
		if g.has_method("enable_cross"):
			g.enable_cross(false)
#		g.visable = true
	var closest = get_closest_grappable()
	if closest and closest.has_method("enable_cross"):
		closest.enable_cross(true)
	
	match state:
		States.FLOOR:
			#State switching
			can_djump = true
			if should_climb_ladder():
				state = States.LADDER
				$Tall.disabled = false
				$Short.disabled = true
				continue
			elif Input.is_action_just_pressed("jump"):
				velocity.y = JUMP_STRENGTH
				anim.play("Final Jump")
				state = States.AIR
				$Tall.disabled = false
				$Short.disabled = true
				continue
			elif $Chain.hooked:
				state = States.GRAPPLE
				$Tall.disabled = false
				$Short.disabled = true
				continue
			elif not is_on_floor():
				state = States.AIR
				CoyoteTime.set_paused(false)
				CoyoteTime.start()
				coyote = true
				$Tall.disabled = false
				$Short.disabled = true
				continue
			else:
				CoyoteTime.set_wait_time(.15)

			
			if Input.is_action_pressed("left"): #FLOOR code
				anim.flip_h = true
#				standbox.position.x = 0
#				crouchbox.position.x = 0
#				LadderDetect.position.x = 0
				if Input.is_action_pressed("run"):
					velocity.x = -RUN_SPEED
					anim.play("Final Run")
				elif Input.is_action_pressed("crouch") and is_on_floor():
					velocity.x = -CROUCH_SPEED
					anim.play("Final Crouch Walk")
				else:
					velocity.x = -WALK_SPEED
					anim.play("Final Run")
			elif Input.is_action_pressed("right"):
				anim.flip_h = false
#				standbox.position.x = 0
#				crouchbox.position.x = 0
#				LadderDetect.position.x = 0
				if Input.is_action_pressed("run"):
					velocity.x = RUN_SPEED
					anim.play("Final Run")
				elif Input.is_action_pressed("crouch") and is_on_floor():
					velocity.x = CROUCH_SPEED
					anim.play("Final Crouch Walk")
				else:
					velocity.x = WALK_SPEED
					anim.play("Final Run")
			else:
				velocity.x = 0
				anim.play("Final Idle")
				if Input.is_action_pressed("crouch"):
					anim.play("Final Crouch")
					$Tall.disabled = true
					$Short.disabled = false
				if Input.is_action_just_released("crouch"):
					$Tall.disabled = false
					$Short.disabled = true
# warning-ignore:return_value_discarded
			move_and_slide(velocity, Vector2.UP,false,4,PI/4,false)
			for index in get_slide_count():
				var collision = get_slide_collision(index)
#				print(collision.collider)
				if collision.collider.is_in_group("bodies"):
					collision.collider.apply_central_impulse(-collision.normal *
					inertia)
		States.AIR:
			#State switching
			if is_on_floor():
				state = States.FLOOR
				continue
			elif should_climb_ladder():
				state = States.LADDER
				continue
			elif $Chain.hooked:
				state = States.GRAPPLE
				continue
			$Tall.disabled = false
			$Short.disabled = true
			
			#jump cutting
			if Input.is_action_just_released("jump") and velocity.y < -100:
				velocity.y *= .5
			
			velocity.y += GRAVITY #AIR code
			if is_on_ceiling():
				velocity.y = GRAVITY
			if velocity.y > 0:
				anim.play("Final Fall")
			if velocity.y < 0:
				anim.play("Final Jump")
			if Input.is_action_pressed("left"):
				anim.flip_h = true
				if Input.is_action_pressed("run"):
					velocity.x = -RUN_SPEED
				else:
					velocity.x = -WALK_SPEED
			elif Input.is_action_pressed("right"):
				anim.flip_h = false
				if Input.is_action_pressed("run"):
					velocity.x = RUN_SPEED
				else:
					velocity.x = WALK_SPEED
			else:
				velocity.x = lerp(velocity.x, 0, 0.2)
			if Input.is_action_just_pressed("jump") and coyote and not CoyoteTime.is_paused():
				velocity.y = JUMP_STRENGTH
				CoyoteTime.stop()
				coyote = false
			elif Input.is_action_just_pressed("jump") and can_djump:
				can_djump = false
				velocity.y = JUMP_STRENGTH
			velocity.x *= .85
# warning-ignore:return_value_discarded
			move_and_slide(velocity, Vector2.UP,false,4,PI/4,false)
			for index in get_slide_count():
				var collision = get_slide_collision(index)
				if collision.collider.is_in_group("bodies"):
					collision.collider.apply_central_impulse(-collision.normal *
					inertia)
		States.GRAPPLE:
			if not $Chain.hooked:
				state = States.AIR
				if velocity.y < 0:
					velocity.y = -100
				else:
					velocity.y = 0
				continue
			chain_velocity = $Chain.tip.normalized() * CHAIN_PULL
#			velocity = velocity.move_toward(hook_position, 2)
#			move_and_slide(velocity)
			
			self.position = lerp(self.position, $Chain.tip, .2)
			
#			move_and_slide(chain_velocity)
			if $Chain/Links.region_rect.size.y < 10:
				$Chain.release()
		States.LADDER:
			if not on_ladder:
				state = States.AIR
				continue
			elif is_on_floor() and Input.is_action_pressed("crouch"):
				state = States.FLOOR
				continue
			can_grapple = false
			
			if Input.is_action_pressed("jump") or Input.is_action_pressed("crouch") or Input.is_action_pressed("left") or Input.is_action_pressed("right"):
				anim.play("Final Climb")
			else:
				anim.stop()
			
			if Input.is_action_pressed("jump"):
				velocity.y = CLIMB_STRENGTH
			elif Input.is_action_pressed("crouch"):
				velocity.y = -CLIMB_STRENGTH
			else:
				velocity.y = lerp(velocity.y,0,0.3)
			if Input.is_action_pressed("left"):
				velocity.x = -CROUCH_SPEED
			elif Input.is_action_pressed("right"):
				velocity.x = CROUCH_SPEED
			else:
				velocity.x = lerp(velocity.x,0,0.3)
			velocity = move_and_slide(velocity, Vector2.UP)
		States.DAMAGE:
			if !hit:
				AudioMng.stream = hurtSound
				AudioMng.play()
				$AnimationPlayer.play("HURT")
				HP -= dp
				velocity.y = -1000
				state = States.AIR
				yield($AnimationPlayer,"animation_finished")
				hit = true
				var timer = get_tree().create_timer(2)
				timer.connect("timeout", self, "_on_timeout")

				if HP < (MAX_HEALTH * 0.25):
					add_child(lowHP)
					print("CRITICAL CONDITION")
			else: 
				state = States.FLOOR
			
	if HP <= 0:
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://JJS_merge/GAMEOVER.tscn")
	hpBar.value = HP
	if hit:
		$AnimationPlayer.play("invincible")

func _on_timeout():
	print("hit the timeout!")
	hit = false
	$AnimationPlayer.play("RESET")

func _on_LadderDetect_body_entered(_body):
	on_ladder = true
func _on_LadderDetect_body_exited(_body):
	on_ladder = false
func should_climb_ladder() -> bool:
	if on_ladder and (Input.is_action_just_pressed("jump") or Input.is_action_just_pressed("crouch")):
		return true
	else:
		return false
func _on_Coyote_timeout():
	coyote = false
	CoyoteTime.set_paused(true)
