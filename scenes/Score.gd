extends Node2D

var scores = [0,0,0]
onready var scoreLabels = [null, get_node("Player1Score"), get_node("Player2Score")]

func setScore(playerNumber, value):
	scoreLabels[playerNumber].text = "Player" + str(playerNumber) + ": " + str(value)
	scores[playerNumber] = value
	
func getScore(playerNumber):
	return scores[playerNumber]