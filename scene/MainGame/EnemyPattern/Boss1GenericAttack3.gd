extends EnemyPattern


func _ready():
	$AnimationPlayer.play("Life")

func shoot_burst(accuracy: float) -> void:
	for i in 20:
		fire_bullet_basic(90-accuracy*0.9,80+i*8)
		fire_bullet_basic(-90+accuracy*0.9,80+i*8)
