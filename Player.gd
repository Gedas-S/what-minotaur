extends Camera

export var speed = 2
var velocity = Vector3(0,0,0)

func _ready():
	self.make_current()

func _process(delta):
	var orientation = Quat(Vector3(0,1,0), self.rotation.project(Vector3(0,1,0)).angle_to(Vector3(0,1,0)))
	print(rotation)
	print(self.rotation.project(Vector3(0,1,0)))
	print(self.rotation.project(Vector3(0,1,0)).angle_to(Vector3(1,0,0)))
	print(Vector3(2,0,1).angle_to(Vector3(1,0,0)))
	print(orientation)
	print(orientation.xform(velocity.normalized()))
	self.translate(orientation.xform(velocity.normalized())*speed*delta)
	
func _unhandled_input(event):
	if event is InputEventKey:
		if event.scancode == KEY_S:
			velocity.z = int(event.pressed) * -1
		elif event.scancode == KEY_W:
			velocity.z = int(event.pressed) * 1
		elif event.scancode == KEY_D:
			velocity.x = int(event.pressed) * -1
		elif event.scancode == KEY_A:
			velocity.x = int(event.pressed) * 1
