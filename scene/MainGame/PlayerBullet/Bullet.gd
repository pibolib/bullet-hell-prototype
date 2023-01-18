extends Node2D

var hit_explosion: PackedScene = preload("res://scene/FX/PlayerHitExplosion.tscn")
@export var start_point: Vector2 = Vector2(0,0)
@export var target_point: Vector2 = Vector2(0,0)
var angle: float = 0

func _ready():
	target_point = start_point + Vector2(sin(angle),cos(angle))*1000
	$EnemyBulletVoid.rotation = start_point.angle_to_point(target_point) + PI
	$EnemyBulletVoid.position = lerp(start_point,target_point,1)
	$Visual.points = [start_point,target_point]
	$RayCast2D.position = start_point
	$RayCast2D.rotation = -angle + PI/2
	$AnimationPlayer.play("Life")
	$RayCast2D.force_raycast_update()
	$Timer.start(0.1)
	var collider = $RayCast2D.get_collider()
	if collider != null:
		if collider.state != 0:
			collider.take_damage()
			var collision_point = $RayCast2D.get_collision_point()
			$Visual.points = [start_point,collision_point]
			$EnemyBulletVoid.position = lerp(start_point,collision_point,1)
			$EnemyBulletVoid.scale.x = start_point.distance_to(collision_point)
			var new_effect = hit_explosion.instantiate()
			new_effect.position = $RayCast2D.get_collision_point()
			get_parent().add_child(new_effect)
	else:
		$EnemyBulletVoid.scale.x = start_point.distance_to(target_point)


func _on_timer_timeout():
	$Timer.stop()
	$EnemyBulletVoid.queue_free()
