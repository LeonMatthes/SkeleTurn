extends Area2D

var enteredBodies = []

func _ready():
	pass

func _on_SpawnArea_body_entered(body):
	if enteredBodies.find(body) < 0: # find returns -1 if not found
		enteredBodies.append(body)


func _on_SpawnArea_body_exited(body):
	enteredBodies.erase(body)

func isEmpty():
	return enteredBodies.size() == 0