extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


export (PackedScene) var WallSegment
export (PackedScene) var BreakableWall

# Called when the node enters the scene tree for the first time.
func _ready():
	var mg = load("res://maze_generator.gd").new()
	var maze = mg.prim(10,10)
	var mazeWalls = makeMaze(maze.underlying, 3)
	for idx in range(mazeWalls.size()):
		add_child(mazeWalls[idx])
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func makeMaze(grid: Array, wallSize: int):
	var stepSize = wallSize / 2.0
	var walls = []
	for x in range(grid.size()):
		var xOdd = x % 2 == 1
		for y in range(grid[x].size()):
			var yOdd = y % 2 == 1
			
			if xOdd && !yOdd && grid[x][y] == 1:
				var q = WallSegment.instance()
				q.translate(Vector3(x * stepSize, 0, y*stepSize))
				q.BreakableWall = BreakableWall
				walls.append(q)
			elif !xOdd && yOdd && grid[x][y] == 1:
				var q = WallSegment.instance()
				q.translate(Vector3(x * stepSize, 0, y*stepSize))
				q.BreakableWall = BreakableWall
				q.rotate(Vector3(0, 1, 0), deg2rad(90))
				walls.append(q)
	return walls