extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var velocity = Vector2()
var gravityFactor = 1
var gravity = 1500
var speed = 500

func _ready():
	pass

func initialize(var gravityFactor, var position, var direction, var velocity): # constructor
	self.gravityFactor = gravityFactor
	self.translate(position)
	self.velocity.x = velocity.x + speed * direction
	self.velocity.y = velocity.y
	self.get_node("ArrowSprite").scale.x *= direction

func calculateVelocity(delta):
	velocity.y += gravityFactor * gravity * delta

func _physics_process(delta):
	self.calculateVelocity(delta)
	
	var collision = move_and_collide(velocity * delta) # collision is a KinematicCollision2D
	if collision != null:
		if collision.collider.is_in_group("Player"):
			collision.collider.die()
		self.queue_free()