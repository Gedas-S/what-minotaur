extends CSGSphere

# Declare member variables here. Examples:
export var speed = 2
var velocity = Vector3(0,1,0)
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.translate(velocity)
	
func _unhandled_input(event):
	if event is InputEventKey and event.pressed:
	    if event.scancode == KEY_W:
		    self.translate_object_local(Vector3(-1,0,0))
