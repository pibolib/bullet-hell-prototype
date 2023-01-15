extends Area2D

var velocity: Vector2 = Vector2(0,0)
var speed = 60
var angle_offset = 0

func _ready():
	var target = Global.player_pos
	var angle = position.angle_to_point(target)
	velocity = Vector2(cos(angle),sin(angle)) * speed

func _process(delta):
	position += velocity * delta
