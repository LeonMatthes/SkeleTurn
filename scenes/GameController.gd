extends Node2D

var spawns = []

func _ready():
	spawns = $Spawns.get_children()
	self.spawnPlayer(1)
	self.spawnPlayer(2)
	randomize()

func spawnPlayer(var playerNumber):
	var availableSpawns = []
	for spawn in spawns:
		if spawn.canSpawnPlayer():
			availableSpawns.append(spawn)
	
	if availableSpawns.size() == 0:
		breakpoint
	
	var spawnNumber = randi() % availableSpawns.size()
	availableSpawns[spawnNumber].spawnPlayer(self, playerNumber)
	
	
func notifyPlayerDeath(var playerNumber):
	self.spawnPlayer(playerNumber)