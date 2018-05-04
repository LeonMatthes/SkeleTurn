extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export (float) var gravityFactor = 1
var gravity = 2000


var velocity = Vector2()
var speed = 200

var sprite = null

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	sprite = self.get_node("PlayerIcon")

func changeGravity():
	gravityFactor *= -1
	sprite.scale.y *= -1
		

func get_input(delta):
	velocity.x = 0
	if Input.is_action_pressed("ui_right"):
		velocity.x += speed
	if Input.is_action_pressed("ui_left"):
		velocity.x -= speed
	if Input.is_action_just_pressed("ui_up"):
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