extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var velocity = Vector2()
export (float) var gravityFactor = 1
var gravity = 2000
var speed = 200

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func get_input(delta):
	velocity.x = 0
	if Input.is_action_pressed("ui_right"):
		velocity.x += speed
	if Input.is_action_pressed("ui_left"):
		velocity.x -= speed
	if Input.is_action_just_pressed("ui_up"):
		gravityFactor *= -1
	velocity.y += gravityFactor * gravity * delta

func _physics_process(delta):
	self.get_input(delta)
	velocity = self.move_and_slide(velocity)
	


#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#func _process(delta):
	
#	pass