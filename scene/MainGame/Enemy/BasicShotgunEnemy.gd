extends Enemy
class_name BasicShotgunEnemy

var velocity: Vector2 = Vector2(0,0)
@export_range(60,120,1,"or_greater") var repel_distance: float = 60
@export_range(60,250,1) var charge_speed: float = 60
var repel = false
func _ready():
	score = 750
	$RepelZone.scale = Vector2(repel_distance,repel_distance)
	patterns = [load("res://scene/MainGame/EnemyPattern/EnemyPatternShotgunShot.tscn")]
	super()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super(delta)
	if state != Status.PRE_INIT:
		position += velocity * delta
		if repel:
			velocity += Vector2.from_angle(Global.player_pos.angle_to_point(position)) * delta * 80

func handle_state(current_state: Status) -> void:
	super(current_state)
	match current_state:
		Status.INIT:
			init_state(Status.ATTACK)
		Status.LEAVE:
			create_pattern(0)
func init_state(new_state: Status) -> void:
	super(new_state)
	match state:
		Status.LEAVE:
			$Model.set_anim("Idle")
		Status.INIT:
			$Model.set_anim("Attack") # to be replaced with "ShortAttack" on shotgun model
		Status.ATTACK:
			$StateTimer.start(0.05)
			init_state(Status.LEAVE)

func init() -> void:
	velocity = Vector2.from_angle(position.angle_to_point(Global.player_pos)) * charge_speed

func _on_repel_zone_area_entered(_area):
	repel = true
	init_state(Status.ATTACK)
