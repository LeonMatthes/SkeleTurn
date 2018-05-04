extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export (float) var gravityFactor = 1
export (int) var playerNumber = 1
var gravity = 2000


var velocity = Vector2()
var speed = 400

var sprite = null

var moveRightAction = "move_right"
var moveLeftAction = "move_left"

	

func _ready():
	$Player1Icon.set_visible(false)
	sprite = self.get_node("Player" + str(playerNumber) + "Icon")
	sprite.set_visible(true)

func changeGravity():
	gravityFactor *= -1
	sprite.scale.y *= -1
		

func get_input(delta):
	velocity.x = 0
	if Input.is_action_pressed("move_right" + str(playerNumber)):
		velocity.x += speed
	if Input.is_action_pressed("move_left" + str(playerNumber)):
		velocity.x -= speed
	if Input.is_action_just_pressed("change_gravity" + str(playerNumber)):
		self.changeGravity()
	velocity.y += gravityFactor * gravity * delta
	
	if velocity.y * gravityFactor < 0:
		#apply tripple graity if gravity and velocities signs are different
		velocity.y += gravityFactor * gravity * delta * 2

func _physics_process(delta):
	self.get_input(delta)
	velocity = self.move_and_slide(velocity)
	


#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#func _process(delta):
	
#	pass