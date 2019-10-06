extends KinematicBody

export var speed : float = 150
export var sensitivity : float = 1
var velocity : Vector3 = Vector3(0,0,0)
var esc_capture : bool = false
var rotating : bool = true
var mouse_ratio : float = 0
var camera : Camera
var hammer : AnimationPlayer
var hammer_hitter : KinematicBody
var hammer_has_hit : bool = true

func _ready():
	self.camera = self.get_node("PlayerEyes")
	self.camera.make_current()
	self.hammer = self.get_node("Hammer/AnimationPlayer")
	self.hammer_hitter = self.get_node("Hammer/Handle/Head/KinematicBody")
	self.hammer_hitter.connect("body_enter", self, "hammer_hit")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	self.recalculate_ratios()

func _process(delta):
	# warning-ignore:return_value_discarded
	self.move_and_slide((self.transform.xform(velocity.normalized())-self.transform.origin)*speed*delta)
	if (self.hammer.current_animation_position < 1.1 or not self.hammer_has_hit) and self.hammer.current_animation_position > 0.95:
		self.hammer_has_hit = true
		self.hammer_hitter.set_collision_mask_bit(2, true)
	else:
		self.hammer_hitter.set_collision_mask_bit(2, false)

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
			self.hammer.play("SwingHammer")
			self.hammer_has_hit = false
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

func hammer_hit(body):
	pass