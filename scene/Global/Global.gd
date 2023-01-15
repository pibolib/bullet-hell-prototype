extends Node

var player_stats_default: Dictionary = {
	"HP": 3,
	"Score": 0,
}

var player_stats: Dictionary = player_stats_default.duplicate(true)
var player_pos: Vector2 = Vector2(0,0)
