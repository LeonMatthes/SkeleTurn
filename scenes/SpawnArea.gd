extends Area2D

var enteredBodies = []

func _ready():
	pass

func _on_SpawnArea_body_entered(body):
	enteredBodies.append(body)
	print(enteredBodies.size())


func _on_SpawnArea_body_exited(body):
	enteredBodies.erase(body)
	print(enteredBodies.size())

func isEmpty():
	return enteredBodies.size() == 0