extends Node2D

var camera_targets: Array = []
var tumbleweed: PackedScene = preload("res://scene/FX/Tumbleweed.tscn")

func generate_camera_targets() -> void:
	for node in get_children():
		if node is Marker2D:
			camera_targets.append(node.position.y)

func get_camera_targets() -> Array:
	if camera_targets == []:
		generate_camera_targets()
	print(camera_targets)
	return camera_targets

func generate_tumbleweeds() -> void:
	for i in randi_range(4,8):
		var new_tumbleweed = tumbleweed.instantiate()
		new_tumbleweed.position.x = randf_range(-300,-20)
		new_tumbleweed.position.y = randf_range(position.y-350,position.y)
		add_child(new_tumbleweed)


func _on_timer_timeout():
	generate_tumbleweeds()
	$Timer.start(randf_range(6,10))
