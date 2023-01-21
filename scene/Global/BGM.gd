extends Node

var bgm_volume: float = 1
var sfx_volume: float = 1
var bgm_tracks: Array = [
	preload("res://assets/bgm/stage1.ogg")
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
