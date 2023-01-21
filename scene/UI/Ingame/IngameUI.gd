extends Control

var current_score = 0
var display_score = 0

func _ready():
	Global.connect("player_hp_changed",update_hp)
	Global.connect("player_bullets_changed",update_bullets)
	Global.connect("score_changed",update_score)

func update_score(score: int) -> void:
	$ScoreAdd.start(0.05)
	current_score = score

func update_hp(hp: int) -> void:
	$TopLeft/HPIndicator.text = "HP: "+str(hp)

func update_bullets(bullets: int) -> void:
	$TopLeft/Bullets.text = "Bullets: "+str(bullets)

func _on_score_add_timeout():
	if display_score < current_score - 100:
		display_score += 100
	elif display_score < current_score - 10:
		display_score += 10
	else:
		display_score += 1
	if display_score == current_score:
		$ScoreAdd.stop()
	else:
		$ScoreAdd.start(0.05)
	Audio.play_score()
	$TopLeft/Score.text = "Score: "+str(display_score)
