extends EnemyPattern


func _ready():
	for i in 16: #fires 16 rounds in a circular pattern
		fire_bullet_basic(i*22.5,70)
	queue_free()
