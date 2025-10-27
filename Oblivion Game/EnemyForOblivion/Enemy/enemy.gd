extends KinematicBody2D

var speed = 200
var velocity = Vector2()
export var direction = 1 # export allows you to manually change the direction 
var stunned = false 

onready var trash_bag = get_parent().get_parent().get_node("TrashBag")
var trash_bag_pos 
#var trash_bag_position = trash_bag.position
var go_to_trash 

#Nothing happening with func _ready() atm. This was just for debugging
func _ready():
	pass
#	var current = get_node('./')
#	print(current)
#	var children = current.get_children()
#	print(children)
		

#this represents how the enemy moves as the game progesses
func _physics_process(_delta):
	
#The 'for loop' is the same as -> if direction == 1:
		#velocity.x = 200	
	#elif direction == -1:
		#velocity.x = -200
		
#This 'for loop' tells the enemy to flip itself and change direction when it collides into the rocks in the background
	for i in range(get_slide_count()):

		var collision = get_slide_collision(i)
		if collision.normal.x != direction and Global.trash_audio == false and stunned == false:
			direction *= -1
			self.scale.x *= -1
			
			break
			
#	if Global.trash_audio == true:
#		look_at(trash_bag.position)
#		print(trash_bag.position)
#		move_and_slide(velocity * direction)
#		position = position.move_toward(trash_bag.global_position, speed * direction)
	
	velocity.x = speed * direction 
	velocity = move_and_slide(velocity, Vector2.UP) #Vector2.UP allows jump to work
	print(Global.trash_audio)

func _on_Area2D_left_body_entered(body):
	if body.is_in_group("Player") and stunned == false:
		self.scale.x *= -1
		print("Player is on the left. Enemy flip.")
		speed = 0 
#		self.scale.x *= -1
		$Enemy_animation.play("attack")
		print("attack")
		$Player_death.start() 
		
		
func _on_Touch_Enemy_body_entered(body):
	if body.is_in_group("Player") and stunned == false: #This ensures that the attack animation only plays when the enemy collides with the player, not the map 
		speed = 0 
#		self.scale.x *= -1
		$Enemy_animation.play("attack")
		print("attack")
		$Player_death.start() #This is what signals the timer to start 

	
func _on_Player_death_timeout(): #What happens when the timer runs out 
	get_tree().change_scene("res://main_game.tscn")
	print("Level reset.")
	

func _on_Touch_Enemy_area_entered(area): #What happens if stun bullet touches enemy
	if area.is_in_group("Stun_Bullets"):
		stunned = true 
		Global.stunned = true
		print("Enemy stunned")
		speed = 0 
		$Enemy_animation.play("stunned")
		$Stunned.start()

func _on_Stunned_timeout(): #What happens when the enemy is remobilized (after being stunned)
	stunned = false 
	Global.stunned = false 
	speed = 200 
	$Enemy_animation.play("run")
	
func trash_touched(): #THIS FUNCTION IS STILL A WIP. (Make enemy turn and walk to direction of trash bag if player touches it)
#	if Global.trash_audio == true:
#		if position.distance_to(trash_bag_pos) > 2:
#			move_and_slide(velocity)
#			look_at(trash_bag_pos)
	pass
