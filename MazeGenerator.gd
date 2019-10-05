extends Spatial

export (PackedScene) var WallSegment

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	grid(4, 4)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func grid(width=10, height=10):
	var offsetX = width / 2
	var offsetZ = height / 2
	var scaleX = 10
	var scaleY = 10
	
	for i in range(width):
		for j in range(height):
			
			var position = Vector3((i - offsetX)*scaleX, 0, (j - offsetZ)*scaleY)
			
			var q = WallSegment.instance()
			q.translate(position)
			
			var qq = WallSegment.instance()
			qq.translate(position)
			qq.rotate(Vector3(0, 1, 0), deg2rad(90))
			
			add_child(q)
			add_child(qq)
