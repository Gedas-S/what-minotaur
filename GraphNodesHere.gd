extends Spatial


class Nd:
	extends Object
	
	var position : Vector2
	var connections = []
	
	func _init(position : Vector2):
		self.position = position
	
	func join(nd : Nd):
		if not (nd in self.connections):
			self.connections.append(nd)
		if not (self in nd.connections):
			nd.connections.append(self)
	
	func unjoin(nd : Nd):
		if nd in self.connections:
			self.connections.erase(nd)
		if self in nd.connections:
			nd.connections.erase(self)
	
	func delete():
		for nd in connections:
			nd.connections.erase(self)
	
	func print_network():
		print(self)


func _ready():
	var nodes = []
	for i in range(10):
		nodes.append(Nd.new(Vector2(i, 1)))
		if nodes.size() > 0:
			nodes[i-1].join(nodes[i])
	print(nodes)
	nodes[-1].delete()
	print(nodes)