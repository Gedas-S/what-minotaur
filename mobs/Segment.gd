extends RigidBody

var index : int = 0
var parent_segment : PhysicsBody
var follow_distance : float = 0

func _ready():
	self.index = int(self.name[-1])
	self.parent_segment = self.get_node("../Segment"+str(self.index-1))
	self.follow_distance = self.get_node("CollisionShape").shape.radius + self.parent_segment.get_node("CollisionShape").shape.radius
	self.connect("body_entered", self, "collide")

func _process(delta):
	var direction : Vector3 = self.parent_segment.global_transform.origin - self.global_transform.origin
	self.add_central_force(direction * direction.length())
	
func collide(body):
	if body == parent_segment:
		self.linear_velocity = Vector3(0,0,0)
		self.angular_velocity = Vector3(0,0,0)