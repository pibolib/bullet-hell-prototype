extends EnemyBullet

var angle_accel: float = 0
var angle_vel: float = 40
var linear_vel: float = 0
var displacement: float = 0
var start_pos: Vector2

func _ready():
	super()
	linear_vel = velocity.distance_to(Vector2.ZERO)
	start_pos = position
	velocity = Vector2.ZERO
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	angle += angle_vel * delta
	angle_vel += angle_accel * delta
	displacement += linear_vel * delta
	position = start_pos + Vector2.from_angle(angle) * displacement
	super(delta)
