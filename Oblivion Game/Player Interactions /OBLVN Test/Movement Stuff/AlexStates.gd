extends KinematicBody2D

enum States {FLOOR = 1, AIR, GRAPPLE, LADDER}
var state = States.FLOOR

const GRAVITY = 50
const WALK_SPEED = 250
const CROUCH_SPEED = 100
const RUN_SPEED = 600
const JUMP_STRENGTH = -900
const CHAIN_PULL = 600
const CLIMB_STRENGTH = -350
const GRAPPLE_RADIUS = 60

onready var anim = $Anim
onready var crouchbox = $Short
onready var standbox = $Tall
onready var hpBar = $Sizing/hpBar
onready var LadderDetect = $LadderDetect
onready var Chain = $Chain
onready var CoyoteTime = $Coyote

var djump := true
var can_djump := true
var on_ladder := false
var can_grapple := false
var hook_position := Vector2()
var coyote := false
var velocity = Vector2()
var chain_velocity := Vector2()
var mouse
var magnet_collide_with = null
func _ready():
	CoyoteTime.set_wait_time(.5)

func _input(event: InputEvent):
	$GrappleLineDetect.set_cast_to(get_local_mouse_position())
	if (event is InputEventMouseButton
	and event.pressed
	and can_grapple
	and not $GrappleLineDetect.is_colliding()
	and Inventory.selected == 3):
		mouse = get_global_mouse_position()
#		if hook_position.x + GRAPPLE_RADIUS >= mouse.x and hook_position.x - GRAPPLE_RADIUS <= mouse.x and hook_position.y + GRAPPLE_RADIUS >= mouse.y and hook_position.y - GRAPPLE_RADIUS <= mouse.y:
#			print ('yay')
		$Chain.shoot(mouse - self.position)
		print ("hook position = ", hook_position)
		print ("mouse position = ", mouse)
		return true
	else:
		$Chain.release()
		return false

func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_pick"):
		pick_magnet()
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
				anim.play("jump")
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
			can_grapple = true
			
			if Input.is_action_pressed("left"): #FLOOR code
				anim.flip_h = true
				if Input.is_action_pressed("run"):
					velocity.x = -RUN_SPEED
					anim.play("run")
				elif Input.is_action_pressed("crouch") and is_on_floor():
					velocity.x = -CROUCH_SPEED
					anim.play("crouch walk")
				else:
					velocity.x = -WALK_SPEED
					anim.play("run")
			elif Input.is_action_pressed("right"):
				anim.flip_h = false
				if Input.is_action_pressed("run"):
					velocity.x = RUN_SPEED
					anim.play("run")
				elif Input.is_action_pressed("crouch") and is_on_floor():
					velocity.x = CROUCH_SPEED
					anim.play("crouch walk")
				else:
					velocity.x = WALK_SPEED
					anim.play("run")
			else:
				velocity.x = 0
				anim.play("idle")
				if Input.is_action_pressed("crouch"):
					anim.play("crouch")
					$Tall.disabled = true
					$Short.disabled = false
				if Input.is_action_just_released("crouch"):
					$Tall.disabled = false
					$Short.disabled = true
			move_and_slide(velocity, Vector2.UP)
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
			can_grapple = true
			$Tall.disabled = false
			$Short.disabled = true
			
			#jump cutting
			if Input.is_action_just_released("jump") and velocity.y < -100:
				velocity.y *= .5
			
			velocity.y += GRAVITY #AIR code
			if is_on_ceiling():
				velocity.y = GRAVITY
			if velocity.y > 0:
				anim.play("fall")
			if velocity.y < 0:
				anim.play("jump")
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
			move_and_slide(velocity, Vector2.UP)
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
				anim.play("climb")
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
func _on_MouseDetect_area_entered(area):
	can_grapple = true
	hook_position = area.global_position
func _on_MouseDetect_area_exited(_area):
	can_grapple = false

func pick_magnet():
	if not has_node("Node2D") and magnet_collide_with:
		var ref_magnet = magnet_collide_with.get_child(2)
		#ref_magnet.get_node("AlexStates").flip_h = sprite_flip
		magnet_collide_with.remove_child(ref_magnet)
		add_child(ref_magnet)
		magnet_collide_with.queue_free()
	pass

