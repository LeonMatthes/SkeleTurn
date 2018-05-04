extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var velocity = Vector2()
var speed = 400

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	#self.connect("body_entered", self, "_on_Arrow_body_entered")
	pass

func initialize(var xVel, var yVel): # constructor
	self.velocity.x = xVel
	self.velocity.y = yVel

func _physics_process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	var collision = move_and_collide(velocity) # collision is a KinematicCollision2D
	if collision.collider.get_class() == "Player":
		print("Player collision!")
	

#func _on_Arrow_body_entered(body):
#	if body.get_class() == "Player":
#		body.die()
#	self.queue_free()
	
