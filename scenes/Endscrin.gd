extends Container

onready var TitleScreen = preload("res://scenes/Titlescreen_stupid.tscn")

func initialize(var winnerNumber):
	var winnerNode = null
	if winnerNumber == 1:
		winnerNode = self.get_node("HBoxContainer/Redwon")
	else:
		winnerNode = self.get_node("HBoxContainer/Bluewon")
	winnerNode.set_visible(true)
	var timer = Timer.new()
	self.add_child(timer)
	timer.wait_time = 5
	timer.connect("timeout", self, "returnToTitleTimer")
	timer.start()
	
func returnToTitleTimer():
	self.returnToTitle()

func returnToTitle():
	for children in self.get_tree().get_root().get_children():
		children.queue_free()
	
	var titleScreen = TitleScreen.instance()
	self.get_tree().get_root().add_child(titleScreen)

func _process(delta):
	if Input.is_action_just_released("ui_cancel"):
		self.returnToTitle()