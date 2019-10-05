extends Spatial

export (PackedScene) var BreakableWall

var shattered = false
var broken = BreakableWall
func shatter():
	if shattered:
		return
	shattered = true
	remove_child(get_node("MeshInstance"))
	remove_child(get_node("StaticBody"))
	broken = BreakableWall.instance()
	add_child(broken)
	var timer = Timer.new()
	timer.connect("timeout",self,"queue_free")
	timer.set_wait_time(60)
	add_child(timer)
	timer.start()
