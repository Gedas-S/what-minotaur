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
	
	for i in range(width):
		for j in range(height):
			var q = WallSegment.instance()
			q.translate(Vector3((i - offsetX)*1, 0, (j - offsetZ)*1))
			
			print(q.translation)