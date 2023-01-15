extends Node

signal player_hp_changed
signal score_changed
signal player_bullets_changed

var player_stats_default: Dictionary = {
	"HP": 3,
	"Score": 0,
	"Bullets": 6,
}

var player_stats: Dictionary = player_stats_default.duplicate(true)
var player_pos: Vector2 = Vector2(0,0)
var angle: float = 0
var mouse_sensitivity: float = 150
var maximized: bool = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	if Input.is_action_just_pressed("ingame_maximize"):
		if maximized:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		maximized = !maximized

func _input(event):
	if event is InputEventMouseMotion:
		angle -= event.relative.x / mouse_sensitivity
		angle = clamp(angle,-PI/2,PI/2)

func _on_player_hit() -> void:
	player_stats.HP -= 1
	emit_signal("player_hp_changed",player_stats.HP)

func _on_player_fire() -> void:
	player_stats.Bullets -= 1
	emit_signal("player_bullets_changed",player_stats.Bullets)
	
func _on_player_reload() -> void:
	player_stats.Bullets += 1
	emit_signal("player_bullets_changed",player_stats.Bullets)

func _on_score_change(value: int) -> void:
	player_stats.Score += value
	emit_signal("score_changed",player_stats.Score)

func _on_player_graze() -> void:
	_on_score_change(10)
