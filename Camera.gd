extends Camera

# Declare member variables here. Examples:
export var phase = 0
var speed = 36
var radius = 10
var height = 5

# Called when the node enters the scene tree for the first time.
# func _ready():
	# pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	phase = fmod(phase + speed * delta, 360)
	var rad_phase = deg2rad(phase)
	self.look_at_from_position(Vector3(cos(rad_phase) * radius, height, sin(rad_phase) * radius), Vector3(0,0,0), Vector3(0,1,0))
