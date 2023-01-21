extends Enemy

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
var attack_phase = 0
var special_phase_1_move = 0

func _ready():
	patterns = [load("res://scene/MainGame/EnemyPattern/Boss1GenericAttack1.tscn"),load("res://scene/MainGame/EnemyPattern/Boss1GenericAttack2.tscn"),load("res://scene/MainGame/EnemyPattern/Boss1GenericAttack3.tscn"),
	load("res://scene/MainGame/EnemyPattern/Boss1SpecialAttack1Spear.tscn"),load("res://scene/MainGame/EnemyPattern/EnemyPatternCircleShot.tscn"),load("res://scene/MainGame/EnemyPattern/Boss1SpecialAttack2.tscn")]
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
	score = 15000
	hp = 60
	super()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if state != Status.PRE_INIT:
		position = lerp(position,target_pos,lerp_speed*delta)
	super(delta)
	attack_phase = 4-ceil((hp+14)/15)
	$Model.set_hat_visible(attack_phase <= 1)
	$Model.set_goggles_visible(attack_phase <= 2)

func init_state(new_state: Status) -> void:
	super(new_state)
	match state:
		Status.INIT:
			state_timer.start(3)
			$Model.set_anim("Idle")
		Status.READY:
			state_timer.start(3)
			$Model.set_anim("Idle")
		Status.ATTACK:
			$Model.set_anim("Attack")
			if attack_phase % 2 == 0:
				current_shot_count = wrapi(current_shot_count,0,2)
				current_shot_count += 1
				create_pattern(current_shot_count)
				if attack_phase == 2:
					state_timer.start(3)
				else:
					state_timer.start(4)
			elif attack_phase == 1:
				create_pattern(3)
				target_pos.y += 20
				special_phase_1_move += 1
				if special_phase_1_move >= 4:
					target_pos.y -= 80
					create_pattern(4)
					special_phase_1_move = 0
				state_timer.start(1)
			else:
				create_pattern(5)
				state_timer.stop()

func handle_state(current_state: Status) -> void:
	super(current_state)
	match current_state:
		Status.INIT:
			init_state(Status.ATTACK)
		Status.ATTACK:
			init_state(Status.ATTACK)
