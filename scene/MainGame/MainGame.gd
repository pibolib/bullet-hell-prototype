extends Node2D

var camerashake: float = 0

func _process(delta):
	update_camera_shake(delta)

func update_camera_shake(amount: float) -> void:
	camerashake = clamp(camerashake-amount*30,0,20)
	$IngameCamera.offset.x = randf_range(-camerashake,camerashake)

func add_camera_shake(amount: float) -> void:
	camerashake += amount

func _on_player_fire():
	add_camera_shake(1.5)
