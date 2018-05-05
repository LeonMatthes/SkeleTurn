extends Node2D

var spawns = []
var activePlayers = [null, null, null]
onready var TitleScreen = preload("res://scenes/Titlescreen_stupid.tscn")

func _ready():
	spawns = $Spawns.get_children()
	self.spawnPlayer(1)
	self.spawnPlayer(2)
	self.position = Vector2(0,0)
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
	

func returnToTitle():
	for children in self.get_tree().get_root().get_children():
		children.queue_free()
	
	var titleScreen = TitleScreen.instance()
	self.get_tree().get_root().add_child(titleScreen)

func endGame():
	self.returnToTitle()

func notifyPlayerDeath(var playerNumber):
	var scores = get_parent().get_node("Scores")
	scores.setScore(playerNumber, scores.getScore(playerNumber) - 1)
	if scores.getScore(playerNumber) <= 0:
		self.endGame()
		
	activePlayers[playerNumber] = null
	self.spawnPlayer(playerNumber)
	
func _process(delta):
	if Input.is_action_just_released("ui_cancel"):
		self.returnToTitle()