extends EnemyPattern


func _ready():
	for i in 3: #fires three rounds with 10 deg offset
		fire_bullet_basic(-10+10*i,90)
	queue_free()
