extends Node

func remove(worldbox) -> void:
	var plots = get_tree().get_nodes_in_group("plot")

	for plot in plots:

		if worldbox.has_point(plot.position):
			plot.free()

func add(scene, position) -> void:
	var sprite = load(scene).instance()
	sprite.position = position
	add_child(sprite)
