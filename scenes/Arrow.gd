extends Area2D

var velocity = Vector2()
var gravityFactor = 1
var customGravity = 1300
var speed = 700

func _ready():
	pass

func initialize(var gravityFactor, var position, var direction, var velocity): # constructor
	self.gravityFactor = gravityFactor
	self.translate(position)
	self.velocity.x = velocity.x + speed * direction
	self.velocity.y = velocity.y

func calculateVelocity(delta):
	velocity.y += gravityFactor * customGravity * delta

func _physics_process(delta):
	self.calculateVelocity(delta)
	self.translate(velocity * delta)
	self.look_at(self.position + self.velocity * delta)

func _on_Arrow_body_entered(body):
	if body.is_in_group("Player"):
		body.die()
	self.queue_free()

func _on_Arrow_area_entered(area):
	self.queue_free()
