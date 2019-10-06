
func _init():
	return

func pickRandomAndRemove(list):
	var idx = randi() % list.len()
	var val = list[idx]
	list.remove(idx)
	return val
	
class Wall:
	var x: int
	var y: int
	
	func _init(a: int, b: int):
		var aOdd = a % 2 == 1
		var bOdd = b % 2 == 1
		assert(aOdd && !bOdd || !aOdd && bOdd) # walls can be on (odd, even) or (even, odd) coords
		self.x = a
		self.y = b 
		return

class Cell:
	var x: int
	var y: int
	
	func _init(a: int, b: int):
		var aOdd = a % 2 == 1
		var bOdd = b % 2 == 1
		assert(aOdd && bOdd) # cells can only be on nodes of odd coordinates
		self.x = a
		self.y = b 
		return
		
	func walls():
		var nWall = Wall.new(x, y + 1)
		var eWall = Wall.new(x + 1, y)
		var wWall = Wall.new(x - 1, y)
		var sWall = Wall.new(x, y - 1)
		
		return [nWall, eWall, wWall, sWall]
		
	func wallCoords():
		return [[x, y + 1], [x + 1, y], [x, y - 1], [x - 1, y]]

class PrimsGrid:
	var underlying: Array

	func _init(width: int, height: int):
		underlying = underlying_grid(width, height)
		return
		
	func underlying_grid(width: int, height: int):
	
		var fullWidth = 2*width + 1
		var fullHeight = 2*height + 1
	
		var cells = Array()
		for x in range(fullWidth):
			cells.append(Array())
			cells[x].resize(fullHeight)
		
			var xIsOdd = x % 2 == 1
		
			for y in range(fullHeight):
				if xIsOdd & y % 2 == 0 || !xIsOdd && y % 2 == 1:
					cells[x][y] = 1 # initiate all wall cells as 1
				else:
					cells[x][y] = 0	 # initiate the rest as 0
	
		return cells
	
	
# Prim's algorithm from https://en.wikipedia.org/wiki/Maze_generation_algorithm
func prim(width: int, height: int):
	
	var seedCell = Cell.new(randi() % width + 1, randi() % height + 1)
	var visited = Array(seedCell)
	
	var wallList = seedCell.walls() # wall list for initialization and end condition when we run out
	
	return