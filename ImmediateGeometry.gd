extends ImmediateGeometry

func _ready():
	self.begin(Mesh.PRIMITIVE_TRIANGLE_STRIP)
	self.add_vertex(Vector3(1,0,0))
	self.add_vertex(Vector3(-1,0,0))
	self.add_vertex(Vector3(1,2,0))
	self.add_vertex(Vector3(-1,2,0))
	self.add_vertex(Vector3(1,2,0))
	self.add_vertex(Vector3(-1,0,0))
	self.add_vertex(Vector3(1,0,0))
	self.end()
