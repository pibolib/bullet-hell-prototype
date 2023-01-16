class_name Wave
extends Node2D
# Defines an ingame wave. Child nodes will spawn when this wave becomes "active".

var enemies: Array = []
var enemycount: int = 0
@export var wave_minimum_time: int = 5

func _ready():
	$WavePreview.visible = false
	count_wave_enemies()

func count_wave_enemies() -> void:
	for node in self.get_children():
		if node is Enemy:
			enemies.append(node)
			enemycount += 1

func get_wave_enemy_count() -> int:
	return enemycount

func start_wave() -> void:
	position = Vector2(0,0)
	for enemy in enemies:
		enemy.activate()

func _on_enemy_death() -> void:
	enemycount -= 1
	get_parent().current_wave_enemy_count -= 1
	if enemycount == 0:
		get_parent().wave_active = true
		get_parent().get_node("./WaveTimer").start(3)
