extends Node2D

var velocity: float
var time: float = 0

func _ready():
	velocity = randf_range(40,70)
	$Tumbleweed.rotation = randf_range(PI,4*PI)
	
func _process(delta):
	position.x += velocity * delta
	$Tumbleweed.position.y = -4 - abs(sin(time*8))*4
	$Tumbleweed.rotation += velocity * delta / 20
	time += delta
	if position.x > 320:
		queue_free()
