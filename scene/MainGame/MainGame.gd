extends Node2D

var camerashake: float = 0
var current_wave: int = 0
var current_wave_enemy_count = 0
var waves: Array = []
var wave_active: bool = false
var wave_start_position: float = 350
var current_camera_position: float = 350
var current_camera_target: float = 350
var camera_targets: Array = []
var current_wave_time: float = 0

func _ready():
	count_waves()
	camera_targets = $Background.get_camera_targets()
	activate_wave(0)
	Audio.play_track(0)

func _process(delta):
	update_camera_shake(delta)
	if current_wave_enemy_count == 0 and !wave_active and current_wave < waves.size()-1:
		current_wave += 1
		activate_wave(current_wave)
	$Background.position.y = 350 - current_camera_position
	if current_wave_enemy_count > 0:
		current_camera_position = lerp(wave_start_position, current_camera_target, ease(1-$WaveTimer.time_left/current_wave_time,-1.4))
	else:
		current_camera_position = lerp(current_camera_position, current_camera_target, delta*2)

func update_camera_shake(amount: float) -> void:
	camerashake = clamp(camerashake-amount*30,0,20)
	$IngameCamera.offset.x = randf_range(-camerashake,camerashake)

func add_camera_shake(amount: float) -> void:
	camerashake += amount

func _on_player_fire() -> void:
	add_camera_shake(1.5)
	
func _on_player_hit() -> void:
	add_camera_shake(4)

func count_waves() -> void:
	for node in get_children():
		if node is Wave:
			waves.append(node)

func activate_wave(wave: int) -> void:
	current_wave_enemy_count = waves[wave].get_wave_enemy_count()
	waves[wave].start_wave()
	wave_active = true
	$WaveTimer.start(waves[wave].wave_minimum_time)
	current_wave_time = waves[wave].wave_minimum_time
	current_camera_target = camera_targets[wave]
	if wave > 0:
		wave_start_position = camera_targets[wave-1]

func _on_wave_timer_timeout():
	wave_active = false
	$WaveTimer.stop()
