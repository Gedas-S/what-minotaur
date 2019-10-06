
func _init():
	return

func pickRandomAndRemove(list):
	var idx = randi() % list.size()	
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
	
	func cells(maxWidth, maxHeight):
		var neighbourCells = Array()
		if (x % 2 == 1): # this must be horizontal wall
			# a cell can be above and below this wall
			neighbourCells = [makeCellWithinBounds(x, y + 1, maxWidth - 1, maxHeight - 1), makeCellWithinBounds(x, y - 1, maxWidth - 1, maxHeight - 1)]
		else: # must be vertical wall
			# a cell can be to the right and left of this wall
			neighbourCells = [makeCellWithinBounds(x + 1, y, maxWidth - 1, maxHeight - 1), makeCellWithinBounds(x - 1, y, maxWidth - 1, maxHeight - 1)]
		return neighbourCells
		
	func makeCellWithinBounds(cellX, cellY, boundX, boundY):
		return Cell.new(min(max(1, cellX), boundX - 1), min(max(1, cellY), boundY - 1))	
		
	func exists(grid: PrimsGrid):
		return grid.underlying[x][y] == 1

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
	var maxWidth: int
	var maxHeight: int

	func _init(width: int, height: int):
		maxWidth = 2*width + 1
		maxHeight = 2*height + 1
		underlying = underlying_grid(maxWidth, maxHeight)
		return
		
	func underlying_grid(width: int, height: int):
		var grid = Array()
		for x in range(width):
			grid.append(Array())
			grid[x].resize(height)
			var xIsOdd = x % 2 == 1 # precompute this once per `x`
		
			for y in range(height):
				if xIsOdd && y % 2 == 0 || !xIsOdd && y % 2 == 1:
					grid[x][y] = 1 # initiate all wall cells as 1
				else:
					grid[x][y] = 0	 # initiate the rest as 0
		return grid
		
	func visit(cell: Cell):
		underlying[cell.x][cell.y] = 1
	func isVisited(cell: Cell):
		return underlying[cell.x][cell.y] == 1
		
	func breakWall(wall: Wall):
		underlying[wall.x][wall.y] = 0
	
# Prim's algorithm from https://en.wikipedia.org/wiki/Maze_generation_algorithm
func prim(width: int, height: int):
	var grid = PrimsGrid.new(width, height)
	
	var seedCell = Cell.new(2*(randi() % width) + 1, 2*(randi() % height) + 1)
	# must keep cells as their coordinates in order to check if `visited` already contains them
	grid.visit(seedCell)
	
	var wallList = seedCell.walls() # wall list for initialization and end condition when we run out
	
	while !wallList.empty():
		var aWall = pickRandomAndRemove(wallList)
		if aWall.exists(grid): # only proceed if the wall has not been broken yet
			var cells = aWall.cells(grid.maxWidth, grid.maxHeight)
		
			# if found unvisited cell behind the wall
			if (!grid.isVisited(cells[0]) || !grid.isVisited(cells[1])):
				grid.visit(cells[0])
				grid.visit(cells[1])
				grid.breakWall(aWall)
				# add walls of the new cell
				wallList = wallList + cells[0].walls()
				wallList = wallList + cells[1].walls()
	
	return grid