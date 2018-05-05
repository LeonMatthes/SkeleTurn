tool
extends Node2D

export (int) var horizontalBlocks = 1 setget setHorizontalBlocks, getHorizontalBlocks
export (int) var verticalBlocks = 1 setget setVerticalBlocks, getVerticalBlocks

func setHorizontalBlocks(var newValue):
	horizontalBlocks = newValue
	updateBlocks()
	
func getHorizontalBlocks():
	return horizontalBlocks

func setVerticalBlocks(var newValue):
	verticalBlocks = newValue
	updateBlocks()

func getVerticalBlocks():
	return verticalBlocks

func updateBlocks():
	for child in self.get_children():
		child.queue_free()
	
	var CenterBlock = preload("res://scenes/Walls/CenterBlock.tscn")
	for x in range(self.horizontalBlocks):
		for y in range(self.verticalBlocks):
			self.spawnBlock(x, y)

func spawnBlock(var horizontalBlock, var verticalBlock):
	var row = verticalBlock % 2
	var BlockClass = preload("res://scenes/Walls/CenterBlock.tscn")
	var BlockTexture = preload("res://graphics/block-1.png") if row == 0 else preload("res://graphics/block-2.png")
	var maxBlockCount = horizontalBlocks - 1
	match horizontalBlock:
		0:
			BlockTexture = preload("res://graphics/block-1-left-corner.png") if row == 0 else preload("res://graphics/block-2-left-corner.png")
		maxBlockCount:
			BlockTexture = preload("res://graphics/block-1-right-corner.png") if row == 0 else preload("res://graphics/block-2-right-corner.png")
	
	if maxBlockCount == 0:
		BlockTexture = preload("res://graphics/block-1-wall.png") if row == 0 else preload("res://graphics/block-2-wall.png")
	
	var block = BlockClass.instance()
	self.add_child(block)
	block.translate(Vector2(horizontalBlock * 64, verticalBlock * 64))
	block.get_node("BlockSprite").texture = BlockTexture


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
