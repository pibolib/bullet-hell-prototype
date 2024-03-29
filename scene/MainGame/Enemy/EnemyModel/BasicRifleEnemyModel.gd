extends EnemyModel
class_name BasicRifleEnemyModel

func _ready():
	super()

func _process(delta):
	super(delta)

func dynamic_anim(anim: String, _time: float) -> void:
	match anim:
		"Attack":
			$ArmAttack.scale.x = 1 - sin(wrapf(aim_dir,0,PI))/4
			$ArmAttack.rotation = aim_dir
	$Legs.position.x = -pos_delta.x*3
	$Legs/Foot1.offset.x = -pos_delta.x*4
	$Legs/Foot2.offset.x = -pos_delta.x*4
	$ArmNeutral.scale.x = sign(pos_delta.x) 

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Attack":
		set_anim("Idle")
