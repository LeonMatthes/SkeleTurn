extends Node2D

var scores = [0,0,0]

func setScore(playerNumber, value):
	get_node("Player" + str(playerNumber) + "Score").text = "Player" + str(playerNumber) + ": " + str(value)
	scores[playerNumber] = value
	
func getScore(playerNumber):
	return scores[playerNumber]