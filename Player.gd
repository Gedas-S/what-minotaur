extends Camera

export var speed = 2
var velocity = Vector3(0,0,0)

func _ready():
	self.make_current()

func _process(delta):
	self.translate(velocity.normalized()*speed*delta)
	
func _unhandled_input(event):
	if event is InputEventKey:
		if event.scancode == KEY_S:
			velocity.x = int(event.pressed) * -1
		elif event.scancode == KEY_W:
			velocity.x = int(event.pressed) * 1
		elif event.scancode == KEY_D:
			velocity.z = int(event.pressed) * 1
		elif event.scancode == KEY_A:
			velocity.z = int(event.pressed) * -1
