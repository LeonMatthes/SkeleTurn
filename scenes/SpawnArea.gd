extends Area2D

var enteredBodies = []

func _ready():
	pass

func _on_SpawnArea_body_entered(body):
	enteredBodies.append(body)


func _on_SpawnArea_body_exited(body):
	enteredBodies.erase(body)

func isEmpty():
	return enteredBodies.size() == 0