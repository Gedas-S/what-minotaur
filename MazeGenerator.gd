extends Spatial

export (PackedScene) var WallSegment

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
#	var mg = load("res://maze_generator.gd").new()
	grid(4, 4)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func rowOfWalls(width: int, offsetVec: Vector3):
	var offsetX = width / 2
	var scaleX = 10
	for i in range(width):
		var position = Vector3((i - offsetX)*scaleX, 0, 0)
		var q = WallSegment.instance()
		q.translate(position + offsetVec)
		add_child(q)

func grid(width=10, height=10):
	var scaleX = 10
	var scaleY = 10
	
	var shiftX = Vector3(scaleX / 2, 0, 0)
	var shiftY = Vector3(0, 0, scaleY / 2)
	
	for i in range(width):
		for j in range(height):
			
			var position = Vector3(i*scaleX, 0, j*scaleY)
			
			var q = WallSegment.instance()
			q.translate(position - shiftX)
			
			var qq = WallSegment.instance()
			qq.translate(position - shiftY)
			qq.rotate(Vector3(0, 1, 0), deg2rad(90))
			
			add_child(q)
			add_child(qq)
			
		var posX = Vector3(i*scaleX, 0, 0) - 2*shiftY
		var q = WallSegment.instance()
		q.translate(posX - shiftX)
		add_child(q)
		
		
	for j in range(height):
		var pos = Vector3(0, 0, j*scaleY) - 2*shiftX
		var q = WallSegment.instance()
		q.translate(pos - shiftY)
		q.rotate(Vector3(0, 1, 0), deg2rad(90))
		add_child(q)
