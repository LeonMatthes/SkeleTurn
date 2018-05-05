extends TextureButton

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _pressed():
	#TODO: load lv1 :)
	for child in get_tree().get_root().get_children():
		child.queue_free()
	
	var lvl3 = preload("res://scenes/Levels/Level6.tscn")
	var lvlInstance = lvl3.instance()
	get_tree().get_root().add_child(lvlInstance)
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass