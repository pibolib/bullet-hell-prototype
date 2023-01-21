extends EnemyModel
class_name AttackDroneModel

func _ready():
	super()

func _process(delta):
	super(delta)

func dynamic_anim(_anim: String, _time: float) -> void:
	pass

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Attack":
		set_anim("Idle")
