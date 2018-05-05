extends Node2D

var scores = [0,10,10]
onready var scoreLabels = [null, get_node("Player1Score"), get_node("Player2Score")]

func _ready():
	setScore(1, scores[1])
	setScore(2, scores[2])

func setScore(playerNumber, value):
	scoreLabels[playerNumber].text = "Player" + str(playerNumber) + ": " + str(value)
	scores[playerNumber] = value
	
func getScore(playerNumber):
	return scores[playerNumber]