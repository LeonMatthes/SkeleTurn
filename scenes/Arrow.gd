extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var xVel
var yVel


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _init(var xVel, var yVel): # constructor
	self.xVel = xVel
	self.yVel = yVel

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	pass