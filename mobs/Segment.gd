extends KinematicBody

var follow_distance : float = 0

func _ready():
	self.follow_distance = self.get_node("CollisionShape").shape.radius + self.get_node("../CollisionShape").shape.radius

func _process(delta):
	var direction : Vector3 = self.get_parent().transform.origin - self.transform.origin
	var vector = direction.normalized() * (direction.length() - follow_distance)
	self.move_and_slide_with_snap(vector, direction)
