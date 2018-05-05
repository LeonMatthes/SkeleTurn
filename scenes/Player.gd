extends KinematicBody2D

export (float) var gravityFactor = 1
export (int) var playerNumber = 1
var gravity = 2000


var velocity = Vector2()
var speed = 400

var sprite = null
var animationPlayer = null
var inputDisabled = false

var moveRightAction = "move_right"
var moveLeftAction = "move_left"

var gameController = null

var Arrow = preload("res://scenes/Arrow.tscn")
var canShoot = true
var shootTimeOut = 0.3
onready var shootTimer = Timer.new()


func _ready():
	self.initialize(null, self.position, self.playerNumber, self.gravityFactor)
	
func initialize(var gameController, var position, var playerNr, var gravityFactor):
	self.gameController = gameController
	self.playerNumber = playerNr
	
	self.get_node("Player1Icon").set_visible(false)
	self.get_node("Player2Icon").set_visible(false)
	self.sprite = self.get_node("Player" + str(playerNumber) + "Icon")
	self.sprite.set_visible(true)
	self.animationPlayer = self.sprite.get_node("AnimationPlayer")
	
	self.translate(position)
	self.setGravityFactor(gravityFactor)
	
	self.shootTimer.wait_time = self.shootTimeOut
	self.shootTimer.connect("timeout", self, "_on_shootTimer_timeout")
	self.add_child(shootTimer)
	

func setGravityFactor(var gravityFactor):
	self.gravityFactor = gravityFactor
	self.sprite.scale.y = self.gravityFactor

func changeGravity():
	self.setGravityFactor(gravityFactor * -1)


func playAnimation():
	if !animationPlayer.is_playing():
		animationPlayer.play("Moving")
	
func stopAnimation():
	if animationPlayer.is_playing():
		animationPlayer.stop(false)
	

func getInput():
	#handle movement input
	if inputDisabled:
		return
	
	velocity.x = 0
	if Input.is_action_pressed("move_right" + str(playerNumber)):
		velocity.x += speed
	if Input.is_action_pressed("move_left" + str(playerNumber)):
		velocity.x -= speed
	
	if velocity.x != 0:
		self.playAnimation()
	else:
		self.stopAnimation()
	
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

func getWidth():
	return self.get_node("PlayerCollisionBox").shape.extents.x

func shootArrow(var direction):
	if !canShoot:
		return
	self.changeGravity()
	var arrow = Arrow.instance()
	self.get_parent().add_child(arrow)	
	
	var xVel = 0
	if !self.velocity.x * direction < 0:
		xVel += self.velocity.x / 5
	var yVel = 0
	
	var xOffset = (self.getWidth() + arrow.get_node("ArrowCollision").shape.extents.x / 2) * direction
	var position = self.position + Vector2(xOffset, 0)
	
	var yDirection = 0
	if Input.is_action_pressed("aim_down" + str(playerNumber)):
		yDirection += 1
	if Input.is_action_pressed("aim_up" + str(playerNumber)):
		yDirection -= 1
	
	var shootDirection = Vector2(direction, yDirection).normalized()
	
	arrow.initialize(self.gravityFactor, position, shootDirection, Vector2(xVel, yVel))
	
	self.canShoot = false
	self.shootTimer.start()

func _on_shootTimer_timeout():
	canShoot = true

func _on_deathTimer_timeout():
	self.queue_free()

func die():
	gameController.notifyPlayerDeath(playerNumber)
	
	animationPlayer.play("Dying", -1, 3.0) #todo change to dying
	self.set_physics_process(false)
	self.get_node("PlayerCollisionBox").disabled = true
	
	var timer = Timer.new()
	timer.connect("timeout",self,"_on_deathTimer_timeout") 
	timer.wait_time = 0.5
	add_child(timer)
	timer.start()
	