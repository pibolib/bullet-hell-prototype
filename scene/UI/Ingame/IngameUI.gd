extends Control

func _ready():
	Global.connect("player_hp_changed",update_hp)

func update_score(score: int) -> void:
	$TopLeft/Score.text = "Score: "+str(score)

func update_hp(hp: int) -> void:
	$TopLeft/HPIndicator.text = "HP: "+str(hp)
