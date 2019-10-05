extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	return
	var kebabas = Plane(1,1,1,1)
	var ig = ImmediateGeometry.new()
	ig.add_sphere(0, 0, 5)
	print(kebabas.center())

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
