extends Spatial

export (PackedScene) var Rubble

var height = 3
var width = 3
var thickness = 0.2
var rubble = 0.2
var pieces = []

func _ready():
	var origin = Vector3(-(width - rubble)/2, rubble/2, -(thickness - rubble)/2)
	for i in range(width / rubble):
		for j in range(height / rubble):
			for k in range(thickness / rubble):
				var box = Rubble.instance()
				box.translate(origin + Vector3(i, j, k) * rubble)
				add_child(box)
				pieces.append(box)

func despawn():
	for piece in pieces:
		piece.remove_child(piece.get_node("CollisionShape"))
	var timer = Timer.new()
	timer.connect("timeout",self,"queue_free")
	timer.set_wait_time(1)
	add_child(timer)
	timer.start()