extends Node

signal player_hp_changed
signal score_changed

var player_stats_default: Dictionary = {
	"HP": 3,
	"Score": 0,
}

var player_stats: Dictionary = player_stats_default.duplicate(true)
var player_pos: Vector2 = Vector2(0,0)
var angle: float = 0
var mouse_sensitivity: float = 150
var maximized: bool = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(delta):
	if Input.is_action_just_pressed("ingame_maximize"):
		if maximized:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		maximized = !maximized
	var viewport_position: Vector2 = get_viewport().get_visible_rect().size/2
	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	var mouse_delta: float = mouse_position.x - viewport_position.x 
	get_viewport().warp_mouse(get_viewport().get_visible_rect().size/2) 
	angle -= mouse_delta / mouse_sensitivity
	angle = clamp(angle, -PI/2, PI/2)

func _on_player_hit():
	player_stats.HP -= 1
	emit_signal("player_hp_changed",player_stats.HP)
