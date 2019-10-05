extends KinematicBody

export var speed = 100
export var sensitivity = 1
var velocity = Vector3(0,0,0)
var esc_capture = false
var rotating = true
var mouse_ratio = 0
var camera = Camera

func _ready():
	self.camera = self.get_node("PlayerEyes")
	self.camera.make_current()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	self.recalculate_ratios()
	self.translate(Vector3(0,0,10))

func _process(delta):
	self.move_and_slide((self.transform.xform(velocity.normalized())-self.transform.origin)*speed*delta)

func _unhandled_input(event):
	if event is InputEventKey:
		if event.scancode == KEY_S:
			velocity.z = int(event.pressed) * 1
		elif event.scancode == KEY_W:
			velocity.z = int(event.pressed) * -1
		elif event.scancode == KEY_D:
			velocity.x = int(event.pressed) * 1
		elif event.scancode == KEY_A:
			velocity.x = int(event.pressed) * -1
		elif event.scancode == KEY_E:
			self.get_parent().get_node("WallSegment2").shatter()
		elif event.scancode == KEY_ESCAPE and event.pressed != esc_capture:
			esc_capture = event.pressed
			if event.pressed:
				rotating = not rotating
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED if rotating else Input.MOUSE_MODE_VISIBLE)
	elif event is InputEventMouseMotion and rotating:
		self.rotate(Vector3(0,1,0), event.relative.x * mouse_ratio)
		self.camera.rotate(self.camera.transform.xform(Vector3(1,0,0)) - self.camera.transform.origin, event.relative.y * mouse_ratio)

func recalculate_ratios():
	mouse_ratio = -deg2rad(self.camera.fov) * sensitivity / get_viewport().size[0]
