extends ImmediateGeometry

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
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


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
