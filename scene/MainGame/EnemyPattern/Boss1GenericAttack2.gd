extends EnemyPattern


func _ready():
	$AnimationPlayer.play("Life")

func shoot_rotating_spiral(count: int = 0) -> void:
	for i in 15:
		for j in 3 + count:
			fire_bullet_rotating(i*24+20*j*-(count % 2),70+20*j-10*count,5 * -(count % 2),0,true)

