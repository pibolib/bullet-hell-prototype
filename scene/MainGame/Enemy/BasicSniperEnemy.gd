extends Enemy
class_name BasicSniperEnemy

enum EntryDirections {
	FROM_TOP,
	FROM_BOTTOM,
	FROM_LEFT,
	FROM_RIGHT
}

@export_enum("From Top","From Bottom","From Left","From Right") var entry_dir: int = EntryDirections.FROM_TOP
@export_range(3,10,1) var shot_count: int = 3
var current_shot_count = 0
var target_pos = Vector2(0,0)
var lerp_speed = 10
var tracking_angle = PI/2
func _ready():
	patterns = [load("res://scene/MainGame/EnemyPattern/EnemyPatternSniperShot.tscn")]
	target_pos = position
	match entry_dir:
		EntryDirections.FROM_TOP:
			position.y = -30
		EntryDirections.FROM_BOTTOM:
			position.y = 380
		EntryDirections.FROM_LEFT:
			position.x = -30
		EntryDirections.FROM_RIGHT:
			position.x = 330
	despawn_border = 31
	dodges = 1
	super()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if state != Status.PRE_INIT:
		position = lerp(position,target_pos,lerp_speed*delta)
		tracking_angle = lerp_angle(tracking_angle,-get_angle_to_player(global_position)+PI/2,delta*4)
	super(delta)

func init_state(new_state: Status) -> void:
	super(new_state)
	match state:
		Status.INIT:
			state_timer.start(3)
			$Model.set_anim("Idle")
		Status.ATTACK:
			state_timer.start(4)
			$Model.set_anim("Attack")
		Status.LEAVE:
			$Model.set_anim("Idle")
			lerp_speed = 1
			match entry_dir:
				EntryDirections.FROM_TOP:
					target_pos.y = -101
				EntryDirections.FROM_BOTTOM:
					target_pos.y = 451
				EntryDirections.FROM_LEFT:
					target_pos.x = -101
				EntryDirections.FROM_RIGHT:
					target_pos.x = 401

func handle_state(current_state: Status) -> void:
	super(current_state)
	match current_state:
		Status.INIT:
			init_state(Status.ATTACK)
		Status.ATTACK:
			create_pattern(0)
			current_shot_count += 1
			if current_shot_count >= shot_count:
				init_state(Status.LEAVE)
			else:
				init_state(Status.INIT)

func dodge(bullet: PlayerBullet) -> void:
	if global_position.x < bullet.collision_point.x:
		target_pos.x -= 20
	else:
		target_pos.x += 20
	super(bullet)
