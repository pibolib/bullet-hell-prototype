extends EnemyPattern


# Called when the node enters the scene tree for the first time.
func _ready():
	shoot_spear(Vector2(-60,0),7)
	shoot_spear(Vector2(60,0),7)
	queue_free()

func shoot_spear(pos_offset: Vector2,count: int) -> void:
	for i in count:
		for j in 2:
			fire_bullet_pos((1-2*j)*i,120-8*i,pos_offset,true)
	for i in 10:
		fire_bullet_pos(0,120-8*i,pos_offset,true)
