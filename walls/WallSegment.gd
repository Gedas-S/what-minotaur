extends Spatial

export (PackedScene) var BreakableWall

func shatter():
	remove_child(get_node("MeshInstance"))
	remove_child(get_node("StaticBody"))
	add_child(BreakableWall.instance())
