extends RigidBody

var follow_distance : float = 0

func _ready():
	self.follow_distance = self.get_node("CollisionShape").shape.radius + self.get_node("../Worm/CollisionShape").shape.radius

func _process(delta):
	var direction : Vector3 = self.get_parent().get_node("Worm").global_transform.origin - self.global_transform.origin
	var vector = direction * 5
	self.add_central_force(vector)