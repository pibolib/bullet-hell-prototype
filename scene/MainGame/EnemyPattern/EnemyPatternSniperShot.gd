extends EnemyPattern

func _ready():
	fire_bullet_hitscan(rad_to_deg(get_parent().tracking_angle))
	queue_free()
