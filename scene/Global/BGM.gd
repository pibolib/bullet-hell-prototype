extends Node

var bgm_volume: float = 1
var sfx_volume: float = 1
var bgm_tracks: Array = [
	preload("res://assets/bgm/stage1.ogg"),
	preload("res://assets/bgm/boss1.ogg")
]

func _ready():
	pass

func _process(_delta):
	pass
	
func set_bgm_volume(vol: float) -> void:
	AudioServer.set_bus_volume_db(1,linear_to_db(vol))
	bgm_volume = vol

func set_sfx_volume(vol: float) -> void:
	AudioServer.set_bus_volume_db(2,linear_to_db(vol))
	sfx_volume = vol

func play_track(track_id: int) -> void:
	if $BGMPlayer.playing:
		$Mixer.play("Fadeout")
		await $Mixer.animation_finished
	$BGMPlayer.stream = bgm_tracks[track_id]
	$BGMPlayer.play()
	$BGMPlayer.volume_db = 0

func fade_out() -> void:
	if $BGMPlayer.playing:
		$Mixer.play("Fadeout")
		await $Mixer.animation_finished
		$BGMPlayer.stop()

func stop_track() -> void:
	if $BGMPlayer.playing:
		$BGMPlayer.stop()

func play_rifle() -> void:
	$Rifle.play()
func play_shotgun() -> void:
	$Shotgun.play()
func play_sniper() -> void:
	$Sniper.play()
func play_spammable() -> void:
	$Spammable.play()
func play_explosion() -> void:
	$Explosion.pitch_scale = randf_range(0.95,1.05)
	$Explosion.play()
func play_dodge() -> void:
	$Dodge.play()
func play_graze() -> void:
	$Graze.play()
