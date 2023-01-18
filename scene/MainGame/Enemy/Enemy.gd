extends Area2D

class_name Enemy

enum Status {
	PRE_INIT,
	INIT,
	ATTACK,
	LEAVE
}

signal enemy_died

var death_explosion: PackedScene = preload("res://scene/FX/EnemyDeathExplosion.tscn")
var patterns: Array = [preload("res://scene/MainGame/EnemyPattern/EnemyPatternBasicShot.tscn")]
var state = Status.PRE_INIT
var game: Node
var score: int = 300
var current_attack = 0
var despawn_border = 100
@export var first_idle = 1.5
var first = true
@export_range(1,11,0.25,"suffix: seconds") var spawn_delay: float = 1
@export var hp: int = 1
@export var patterns_overwrite: Array[PackedScene] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	game = get_parent().get_parent()
	process_mode = Node.PROCESS_MODE_DISABLED
	$Model.visible = false
	self.connect("enemy_died",get_parent()._on_enemy_death)
	if patterns_overwrite.size() > 0:
		patterns = patterns_overwrite

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if hp <= 0:
		var new_death_anim = death_explosion.instantiate()
		new_death_anim.position = position
		game.add_camera_shake(4)
		get_parent().add_child(new_death_anim)
		emit_signal("enemy_died")
		Global._on_score_change(score)
		queue_free()
	if state != Status.PRE_INIT:
		$Model.set_aim_dir(get_angle_to_player(position))
		if position.x < -despawn_border or position.x > 300+despawn_border or position.y > 350+despawn_border or position.y < -despawn_border:
			emit_signal("enemy_died")
			queue_free()

func take_damage():
	hp -= 1

func handle_state(current_state: Status) -> void:
	match current_state:
		Status.PRE_INIT:
			init()
			init_state(Status.INIT)

func _on_state_timer_timeout():
	$StateTimer.stop()
	handle_state(state)
	
func init_state(new_state: Status) -> void:
	state = new_state
	match state:
		Status.PRE_INIT:
			$StateTimer.start(spawn_delay)
			process_mode = Node.PROCESS_MODE_INHERIT

func create_pattern(id: int) -> void:
	var new_pattern = patterns[id].instantiate()
	add_child(new_pattern)

func get_angle_to_player(start_pos: Vector2) -> float:
	var target = Global.player_pos
	return start_pos.angle_to_point(target)

func activate() -> void:
	init_state(Status.PRE_INIT)
	$Model.visible = true

func init() -> void:
	pass
