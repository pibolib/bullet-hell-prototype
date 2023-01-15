extends Node2D

var hit_explosion: PackedScene = preload("res://scene/FX/PlayerHitExplosion.tscn")
@export var start_point: Vector2 = Vector2(0,0)
@export var target_point: Vector2 = Vector2(0,0)
var angle: float = 0

func _ready():
	target_point = start_point + Vector2(sin(angle),cos(angle))*1000
	$EnemyBulletVoid.rotation = start_point.angle_to_point(target_point)
	$EnemyBulletVoid.position = lerp(start_point,target_point,0.5)
	$Visual.points = [start_point,target_point]
	$RayCast2D.position = start_point
	$RayCast2D.rotation = -angle + PI/2
	$AnimationPlayer.play("Life")
	$RayCast2D.force_raycast_update()
	var collider = $RayCast2D.get_collider()
	if collider != null:
		collider.take_damage()
		$Visual.points = [start_point,$RayCast2D.get_collision_point()]
		var new_effect = hit_explosion.instantiate()
		new_effect.position = $RayCast2D.get_collision_point()
		get_parent().add_child(new_effect)
