extends Camera

export var speed = 2
var velocity = Vector3(0,0,0)
var esc_capture = false
var rotating = true

func _ready():
	self.make_current()
	print(get_viewport().size)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	var orientation = Quat(Vector3(0,1,0), self.rotation.project(Vector3(0,1,0)).angle_to(Vector3(0,1,0)))
	self.translate(orientation.xform(velocity.normalized())*speed*delta)
	print(esc_capture)
	
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
		elif event.scancode == KEY_ESCAPE and event.pressed != esc_capture:
			esc_capture = event.pressed
			if event.pressed:
				rotating = not rotating
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED if rotating else Input.MOUSE_MODE_VISIBLE)
	elif event is InputEventMouseMotion:
		pass
