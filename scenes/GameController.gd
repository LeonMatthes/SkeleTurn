extends Node2D

var spawns = []
var activePlayers = [null, null, null]

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
	activePlayers[playerNumber] = availableSpawns[spawnNumber].spawnPlayer(self, playerNumber)
	
func notifyPlayerDeath(var playerNumber):
	var scores = get_parent().get_node("Scores")
	scores.setScore(3 - playerNumber, scores.getScore(3 - playerNumber) + 1)
	activePlayers[playerNumber] = null
	self.spawnPlayer(playerNumber)