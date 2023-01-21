extends EnemyPattern

var times: int = 0
var rifledir: float = 0
var pistoldir: float = 30

func _ready():
	$Timer.start(0.1)

func _on_timer_timeout():
	times += 1
	if times % 2 == 0:
		shoot_rifle(rifledir)
		rifledir += 20 + times
	else:
		if times > 60 and times % 7 == 0:
			shoot_circle(times*30)
		else:
			shoot_single(pistoldir)
		pistoldir -= 10 + times
	$Timer.start(0.05)

func shoot_rifle(angle_offset: float) -> void:
	for i in 5:
		fire_bullet_basic(angle_offset,100+5*i)
		fire_bullet_basic(angle_offset+180,100+5*i)

func shoot_single(angle_offset: float) -> void:
	fire_bullet_basic(angle_offset,60)
	fire_bullet_basic(angle_offset+40,90)

func shoot_circle(angle_offset: float) -> void:
	for i in 16:
		fire_bullet_basic(i*22.5+angle_offset,70)
