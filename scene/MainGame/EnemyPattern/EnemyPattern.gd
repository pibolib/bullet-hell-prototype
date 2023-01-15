extends Node2D

class_name EnemyPattern
var bullet_basic: PackedScene = preload("res://scene/MainGame/EnemyBullet/EnemyBullet.tscn")
@onready var game_level: Node = get_parent().get_parent() # gets game level 

func fire_bullet_basic(angle_offset: float, speed: float, target_player: bool = true) -> void:
	var new_bullet = bullet_basic.instantiate()
	if target_player:
		new_bullet.angle = get_angle_to_player(get_parent().position) + deg_to_rad(angle_offset)
	else:
		new_bullet.angle = deg_to_rad(angle_offset)
	new_bullet.speed = speed
	new_bullet.position = get_parent().position
	game_level.add_child(new_bullet)

func get_angle_to_player(start_pos: Vector2) -> float:
	var target = Global.player_pos
	return start_pos.angle_to_point(target)
