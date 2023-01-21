extends EnemyPattern

func _ready():
	$AnimationPlayer.play("Life")

func shoot_burst(angle_in_degrees: float) -> void:
	for i in 7: 
		fire_bullet_basic(angle_in_degrees + 90,90+30*i,false)
	for i in 4:
		fire_bullet_basic(angle_in_degrees + 270,120+60*i,false)

func shoot_rotating_spiral() -> void:
	for i in 15:
		for j in 3:
			fire_bullet_rotating(i*24+20*j,70+20*j,8,3)
