extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Life")
	$ExplosionX.rotation_degrees = randf_range(-60,60)
	$ExplosionY.rotation_degrees = randf_range(-60,60)
