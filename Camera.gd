extends Camera

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
#func _ready():
#	self.make_current()
#	self.look_at_from_position(Vector3(0, 0, 0), Vector3(1000, 1000, 1000), Vector3(0, 0, 1))
#	self.look_at_from_position(Vector3(0, 0, 0), Vector3(1000, 1000, 1000), Vector3(0, 1, 0))
#	self.look_at_from_position(Vector3(0, 100, 0), Vector3(0, 0, 0), Vector3(0, 1, 0))
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

export var speed = 2
export var sensitivity = 1
var velocity = Vector3(0,0,0)
var esc_capture = false
var rotating = true
var mouse_ratio = 0

func _ready():
	self.make_current()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	self.recalculate_ratios()

func _process(delta):
	self.translate(velocity*speed*delta)
	self.translation.y = 0

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
		elif event.scancode == KEY_ESCAPE and event.pressed != esc_capture:
			esc_capture = event.pressed
			if event.pressed:
				rotating = not rotating
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED if rotating else Input.MOUSE_MODE_VISIBLE)
	elif event is InputEventMouseMotion and rotating:
		self.rotate(Vector3(0,1,0), event.relative.x * mouse_ratio)
		self.rotate(self.transform.xform(Vector3(1,0,0)) - self.transform.origin, event.relative.y * mouse_ratio)

func recalculate_ratios():
	mouse_ratio = -deg2rad(self.fov) * sensitivity / get_viewport().size[0]
