extends Node

signal alter_terrain(function, tag, vector3i, range)

func generate_terrain(density, v3i, v3f):
	for i in range(0, density):
		var x = randi_range(v3i.x, v3f.x)
		var y = randi_range(v3i.y, v3f.y)
		emit_signal("alter_terrain", "fill", Tag.stone, 3, null)
		emit_signal("alter_terrain", "rocky", Tag.stone, Vector3i(x, y, v3i.z), randi()%7)
