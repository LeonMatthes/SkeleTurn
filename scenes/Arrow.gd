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
	self.get_sound("ArrowShot").play()

func get_sound(sound):
	return self.get_parent().get_node("Sound").get_node(sound)

func calculateVelocity(delta):
	velocity.y += gravityFactor * customGravity * delta

func _physics_process(delta):
	self.calculateVelocity(delta)
	self.translate(velocity * delta)
	self.look_at(self.position + self.velocity * delta)
	
#a highly complex function which funnels the arrow to the other side, if it falls out of the map
func _process(delta):
	if position.x<0:
		position.x=1280
	if position.x>1280:
		position.x=0

func _on_Arrow_body_entered(body):
	if body.is_in_group("Player"):
		self.get_sound("ArrowDamage").play()
		body.die()
	self.queue_free()