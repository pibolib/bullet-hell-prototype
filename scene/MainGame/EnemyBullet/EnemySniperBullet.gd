extends Node2D
class_name EnemySniperBullet

@export var start_point: Vector2 = Vector2(0,0)
@export var target_point: Vector2 = Vector2(0,0)
var angle: float = 0
var collision_point = Vector2(0,0)

func _ready():
	target_point = start_point + Vector2(sin(angle),cos(angle))*1000
	$Visual.points = [start_point,target_point]
	$RayCast2D.position = start_point
	$RayCast2D.rotation = -angle + PI/2
	$AnimationPlayer.play("Life")
	$RayCast2D.force_raycast_update()
	var collider = $RayCast2D.get_collider()
	if collider != null:
		collision_point = $RayCast2D.get_collision_point()
		if(collider.hitscan_hit()):
			$Visual.points = [start_point,collider.position-position]
