extends EnemyPattern


func _ready():
	for i in 10: #fires 10 rounds in a circular pattern
		fire_bullet_basic(i*36,70)
	queue_free()
