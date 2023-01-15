extends Control

func _ready():
	Global.connect("player_hp_changed",update_hp)
	Global.connect("player_bullets_changed",update_bullets)
	Global.connect("score_changed",update_score)

func update_score(score: int) -> void:
	$TopLeft/Score.text = "Score: "+str(score)

func update_hp(hp: int) -> void:
	$TopLeft/HPIndicator.text = "HP: "+str(hp)

func update_bullets(bullets: int) -> void:
	$TopLeft/Bullets.text = "Bullets: "+str(bullets)
