extends Position2D

var collisionArea = null
var Player = preload("res://scenes/Player.tscn")
export (bool) var turnGravity = false

func _ready():
	collisionArea = $SpawnArea

func canSpawnPlayer():
	return collisionArea.isEmpty()
	
func spawnPlayer(var gameController, var playerNumber):
	if !self.canSpawnPlayer():
		breakpoint

	var player = Player.instance()
	gameController.add_child(player)
	player.initialize(gameController, self.position, playerNumber, -1 if turnGravity else 1)
	# add player manually, so they don't spawn in the same place
	collisionArea._on_SpawnArea_body_entered(player)