extends Spatial

export (PackedScene) var Rubble

var height = 3
var width = 3
var thickness = 0.2
var rubble = 0.2

func _ready():
	var origin = Vector3(-(width - rubble)/2, rubble/2, -(thickness - rubble)/2)
	for i in range(width / rubble):
		for j in range(height / rubble):
			for k in range(thickness / rubble):
				var box = Rubble.instance()
				box.translate(origin + Vector3(i, j, k) * rubble)
				add_child(box)
