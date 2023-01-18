extends Node2D

var aim_dir: float = 0
var current_anim = ""
# Called when the node enters the scene tree for the first time.
func _ready():
	set_anim("Idle")
	$AnimationPlayer.advance(global_position.x/300)

func _process(_delta):
	dynamic_anim(current_anim, $AnimationPlayer.current_animation_position)

func set_anim(anim_name: String) -> void:
	$AnimationPlayer.play(anim_name)
	current_anim = anim_name

func set_aim_dir(dir: float) -> void:
	aim_dir = dir

func dynamic_anim(anim: String, _time: float) -> void:
	match anim:
		"Attack":
			$Torso/GunAim.rotation = aim_dir - PI/2
			$Torso/Arm1.position = $Torso/GunAim.position - Vector2(cos(aim_dir-PI/16),sin(aim_dir-PI/16))*3 - Vector2(0,1)
			$Torso/Arm2.position = $Torso/GunAim.position + Vector2(cos(aim_dir+PI/16),sin(aim_dir+PI/16))*3 - Vector2(0,1)
		_:
			pass
