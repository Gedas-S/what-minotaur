extends StaticBody

func hammer_hit():
	self.get_parent().shatter()