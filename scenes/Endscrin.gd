extends Container

onready var TitleScreen = preload("res://scenes/Titlescreen_stupid.tscn")

func intialize(var winnerNumber):
	var WinnerNode = null
	if winnerNumber == 1:
		winnerNode = self.get_node("HBoxContainer/Redwon")
	else:
		winnerNode = self.get_node("HBoxContainer/Bluewon")
	winnerNode.set_visible(true)
	var timer = Timer.new()
	timer.wait_time = 10
	timer.connect("timeout", self, "returnToTitleTimer")
	timer.start()
	
func returnToTitleTimer():
	for children in self.get_tree().get_root().get_children():
		children.queue_free()
	
	var titleScreen = TitleScreen.instance()
	self.get_tree().get_root().add_child(titleScreen)