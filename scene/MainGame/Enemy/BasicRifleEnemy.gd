extends Enemy
class_name BasicRifleEnemy

@export_enum("Towards Right","Towards Left") var move_direction: int = 0
@export var move_downwards: bool = false
var velocity = Vector2(0,0)
# Called when the node enters the scene tree for the first time.
func _ready():
	score = 500
	super()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super(delta)
	if state != Status.PRE_INIT:
		position += velocity * delta

func handle_state(current_state: Status) -> void:
	super(current_state)
	match current_state:
		Status.INIT:
			init_state(Status.ATTACK)
		Status.ATTACK:
			create_pattern(0)
			init_state(Status.INIT)

func init_state(new_state: Status) -> void:
	super(new_state)
	match state:
		Status.INIT:
			if first:
				state_timer.start(first_idle)
				first = true
			else:
				state_timer.start(1)
		Status.ATTACK:
			state_timer.start(2)
			$Model.set_anim("Attack")

func init() -> void:
	velocity = Vector2(30 - 60*move_direction,float(move_downwards) * 5)
