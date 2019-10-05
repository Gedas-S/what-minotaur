extends KinematicBody

export var speed = 150
export var sensitivity = 1
var velocity = Vector3(0,0,0)
var esc_capture = false
var rotating = true
var mouse_ratio = 0
var camera = Camera

var hammer = Spatial
var hammer_phase = 5
var hammer_origin = Vector3(0,0,0)
var hammer_rotation = Vector3(0,0,0)
var hammer_last_phase = 0
var hammer_from_loc = Vector3(0,0,0)
var hammer_from_rot = Vector3(0,0,0)

func _ready():
	self.camera = self.get_node("PlayerEyes")
	self.camera.make_current()
	self.hammer = self.get_node("Hammer/Handle")
	self.hammer_origin = self.hammer.transform.origin
	self.hammer_rotation = self.hammer.transform.basis
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	self.recalculate_ratios()
	self.translate(Vector3(0,0,10))

func _process(delta):
	self.move_and_slide((self.transform.xform(velocity.normalized())-self.transform.origin)*speed*delta)
	if hammer_phase < 3:
		hammer_phase += delta
		self.do_hammering(hammer_phase)

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
			if hammer_phase >= 3:
				hammer_phase = 0
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
	
func do_hammering(phase):
	if phase < 1:
		if hammer_last_phase != 1:
			hammer_last_phase = 1
			hammer_from_loc = hammer.transform.origin
			hammer_from_rot = hammer.transform.rotation
		hammer.transform.origin = hammer_from_loc.linear_interpolate(Vector3(0,2,0))