extends Area2D

class_name Enemy

enum Status {
	INIT,
	ATTACK
}

var death_explosion: PackedScene = preload("res://scene/FX/EnemyDeathExplosion.tscn")
var patterns: Array = [preload("res://scene/MainGame/EnemyPattern/EnemyPatternBasicShot.tscn")]
var state = Status.INIT
@export var hp: int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	$StateTimer.start(2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if hp <= 0:
		var new_death_anim = death_explosion.instantiate()
		new_death_anim.position = position
		get_parent().add_child(new_death_anim)
		queue_free()
	$Model.set_aim_dir(get_angle_to_player(position))

func take_damage():
	hp -= 1

func handle_state(current_state: int) -> void:
	match current_state:
		Status.INIT:
			init_state(Status.ATTACK)
		Status.ATTACK:
			create_pattern(0)
			init_state(Status.INIT)

func _on_state_timer_timeout():
	$StateTimer.stop()
	handle_state(state)
	
func init_state(new_state: int) -> void:
	state = new_state
	match state:
		Status.INIT:
			$StateTimer.start(2)
			$Model.set_anim("Idle")
		Status.ATTACK:
			$StateTimer.start(3)
			$Model.set_anim("Attack")

func create_pattern(id: int) -> void:
	var new_pattern = patterns[id].instantiate()
	add_child(new_pattern)

func get_angle_to_player(start_pos: Vector2) -> float:
	var target = Global.player_pos
	return start_pos.angle_to_point(target)
