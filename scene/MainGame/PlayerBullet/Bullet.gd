extends Node2D

@export var start_point: Vector2 = Vector2(0,0)
@export var target_point: Vector2 = Vector2(0,0)

func _ready():
	$EnemyBulletVoid.rotation = start_point.angle_to_point(target_point)
	$EnemyBulletVoid.position = lerp(start_point,target_point,0.5)
	$Visual.points = [start_point,target_point]
	$RayCast2D.position = start_point
	$RayCast2D.target_position = target_point
	$AnimationPlayer.play("Life")
