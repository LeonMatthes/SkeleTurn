extends KinematicBody2D

export (float) var gravityFactor = 1
export (int) var playerNumber = 1
var gravity = 2000


var velocity = Vector2()
var speed = 400

var sprite = null

var moveRightAction = "move_right"
var moveLeftAction = "move_left"

var gameController = null

var Arrow = preload("res://scenes/Arrow.tscn")


func _ready():
	self.initialize(null, self.position, self.playerNumber)
	
func initialize(var gameController, var position, var playerNr):
	self.gameController = gameController
	self.translate(position)
	self.playerNumber = playerNr
	self.get_node("Player1Icon").set_visible(false)
	sprite = self.get_node("Player" + str(playerNumber) + "Icon")
	sprite.set_visible(true)

func changeGravity():
	gravityFactor *= -1
	sprite.scale.y *= -1


func getInput():
	#handle movement input
	velocity.x = 0
	if Input.is_action_pressed("move_right" + str(playerNumber)):
		velocity.x += speed
	if Input.is_action_pressed("move_left" + str(playerNumber)):
		velocity.x -= speed
	
	# handle Arrow shooting
	if Input.is_action_just_pressed("arrow_" + str(playerNumber) + "_left"):
		self.shootArrow(-1)
	if Input.is_action_just_pressed("arrow_" + str(playerNumber) + "_right"):
		self.shootArrow(1)


func updateGravity(delta):
	velocity.y += gravityFactor * gravity * delta
	
	#apply multiple times the gravity if gravity and velocities signs are different
	if velocity.y * gravityFactor < 0:
		velocity.y += gravityFactor * gravity * delta * 2


func _physics_process(delta):
	self.getInput()
	self.updateGravity(delta)
	velocity = self.move_and_slide(velocity)

func shootArrow(var direction):
	self.changeGravity()
	
	var arrow = Arrow.instance()
	var xVel = 0
	if !self.velocity.x * direction < 0:
		xVel += self.velocity.x / 5
	var yVel = 0
	
	var xOffset = (self.get_node("PlayerCollisionBox").shape.extents.x + arrow.get_node("ArrowCollision").shape.extents.x / 2) * direction
	
	self.get_parent().add_child(arrow)
	var position = self.position + Vector2(xOffset, 0)
	arrow.initialize(self.gravityFactor, position, direction, Vector2(xVel, yVel))


func die():
	gameController.notifyPlayerDeath(playerNumber)
	self.queue_free()