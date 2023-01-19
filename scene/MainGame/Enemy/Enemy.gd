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
@export var first_idle = 0
var first = true
var dodges = 0
var max_dodges = 0
@export_range(1,11,0.25,"suffix: seconds") var spawn_delay: float = 1
@export var hp: int = 1
@export var patterns_overwrite: Array[PackedScene] = []
@onready var dodge_regain_timer = Timer.new()
@onready var state_timer = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(dodge_regain_timer)
	add_child(state_timer)
	game = get_parent().get_parent()
	process_mode = Node.PROCESS_MODE_DISABLED
	$Model.visible = false
	self.connect("enemy_died",get_parent()._on_enemy_death)
	dodge_regain_timer.connect("timeout",_on_dodge_regain_timer_timeout)
	state_timer.connect("timeout",_on_state_timer_timeout)
	if patterns_overwrite.size() > 0:
		patterns = patterns_overwrite
	max_dodges = dodges

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

func activate() -> void:
	init_state(Status.PRE_INIT)
	$Model.visible = true

func init() -> void:
	pass

func handle_state(current_state: Status) -> void:
	match current_state:
		Status.PRE_INIT:
			init()
			init_state(Status.INIT)

func init_state(new_state: Status) -> void:
	state = new_state
	match state:
		Status.PRE_INIT:
			state_timer.start(spawn_delay)
			process_mode = Node.PROCESS_MODE_INHERIT

func _on_state_timer_timeout():
	state_timer.stop()
	handle_state(state)

func _on_bullet_collide(bullet: Node2D) -> bool:
	#returns true if the bullet actually collided with the enemy (dealing damage), and false otherwise
	if dodges > 0:
		dodge(bullet)
		return false
	take_damage()
	return true

func take_damage() -> void:
	hp -= 1
	
func dodge(_bullet: PlayerBullet) -> void:
	dodge_regain_timer.start(3)
	dodges -= 1
	
func _on_dodge_regain_timer_timeout() -> void:
	dodges += 1
	if dodges < max_dodges:
		dodge_regain_timer.start(3)
	else:
		dodge_regain_timer.stop()

func create_pattern(id: int) -> void:
	var new_pattern = patterns[id].instantiate()
	add_child(new_pattern)

func get_angle_to_player(start_pos: Vector2) -> float:
	var target = Global.player_pos
	return start_pos.angle_to_point(target)
