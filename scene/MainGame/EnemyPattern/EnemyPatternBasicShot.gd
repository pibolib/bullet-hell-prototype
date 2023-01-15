extends EnemyPattern

func _ready():
#	for i in 3: #fires three rounds with 15 deg offset
#		fire_bullet_basic(-10+10*i,60)
	for i in 3: #fires three rounds with different speeds
		fire_bullet_basic(0,40+10*i)
	queue_free()
