extends Enemy

@export_enum("Towards Right","Towards Left") var move_direction: int = 0
@export var move_downwards: bool = false
var velocity = Vector2(0,0)
# Called when the node enters the scene tree for the first time.
func _ready():
	super()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super(delta)
	position += velocity * delta

func handle_state(current_state: int) -> void:
	match current_state:
		Status.PRE_INIT:
			velocity = Vector2(30 - 60*move_direction,float(move_downwards) * 5)
			init_state(Status.INIT)
			$Model.visible = true
		Status.INIT:
			init_state(Status.ATTACK)
		Status.ATTACK:
			create_pattern(0)
			init_state(Status.INIT)

func init_state(new_state: Status) -> void:
	state = new_state
	match state:
		Status.PRE_INIT:
			process_mode = Node.PROCESS_MODE_INHERIT
			$StateTimer.start(spawn_delay)
		Status.INIT:
			$StateTimer.start(0.5)
			$Model.set_anim("Idle")
		Status.ATTACK:
			$StateTimer.start(3)
			$Model.set_anim("Attack")
