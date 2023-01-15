extends Area2D

class_name EnemyBullet

var velocity: Vector2 = Vector2(0,0)
var speed = 60
var angle = 0

func _ready():
	velocity = Vector2(cos(angle),sin(angle)) * speed

func _process(delta):
	position += velocity * delta
	if position.x < -50 or position.x > 350:
		queue_free()
	if position.y < -50 or position.y > 400:
		queue_free()
