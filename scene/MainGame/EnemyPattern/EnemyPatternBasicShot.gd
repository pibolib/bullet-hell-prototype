extends EnemyPattern

func _ready():
	for i in 5: #fires five rounds with different speeds
		fire_bullet_basic(0,40+5*i)
	queue_free()
