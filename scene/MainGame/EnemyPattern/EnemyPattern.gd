extends Node2D

class_name EnemyPattern
var bullet_basic: PackedScene = preload("res://scene/MainGame/EnemyBullet/EnemyBullet.tscn")

func fire_bullet_basic(angle_offset: float, speed: float, target_player: bool = true) -> void:
	var new_bullet = bullet_basic.instantiate()
	

func get_angle_to_player(start_pos: Vector2) -> float:
	var target = Global.player_pos
	return start_pos.angle_to_point(target)
