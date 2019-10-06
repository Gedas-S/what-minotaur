extends Spatial

export (PackedScene) var WallSegment

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	var mg = load("res://maze_generator.gd").new()
	var maze = mg.prim(10,10)
	for x in range(maze.maxWidth):
		print(maze.underlying[x])
			
	
	makeMaze(maze.underlying, 10)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# takes the underlying array[array] of PrimsGrid
func makeMaze(grid: Array, wallSize: int):
	var stepSize = wallSize / 2
	for x in range(grid.size()):
		var xOdd = x % 2 == 1
		for y in range(grid[x].size()):
			var yOdd = y % 2 == 1
			
			if xOdd && !yOdd && grid[x][y] == 1:
				var q = WallSegment.instance()
				q.translate(Vector3(x * stepSize, 0, y*stepSize))
				add_child(q)
			elif !xOdd && yOdd && grid[x][y] == 1:
				var q = WallSegment.instance()
				q.translate(Vector3(x * stepSize, 0, y*stepSize))
				q.rotate(Vector3(0, 1, 0), deg2rad(90))
				add_child(q)
