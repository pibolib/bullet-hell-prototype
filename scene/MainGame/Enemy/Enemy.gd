extends Area2D

var bullet: PackedScene = preload("res://scene/MainGame/EnemyBullet/EnemyBullet.tscn")
var death_explosion: PackedScene = preload("res://scene/FX/EnemyDeathExplosion.tscn")
var hp: int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Idle")
	$AnimationPlayer.advance(position.x/350)
	$BulletTimer.start(5)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if hp <= 0:
		var new_death_anim = death_explosion.instantiate()
		new_death_anim.position = position
		get_parent().add_child(new_death_anim)
		queue_free()

func _on_animation_player_animation_finished(anim_name):
	$AnimationPlayer.play(anim_name)


func _on_bullet_timer_timeout():
	var new_bullet = bullet.instantiate()
	new_bullet.position = position
	get_parent().add_child(new_bullet)
	$BulletTimer.start(5)

func take_damage() -> void:
	hp -= 1
