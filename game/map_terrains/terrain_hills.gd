extends Node

signal alter_terrain(function, tag, vector3i, range)

func generate_terrain(density, v3i, v3f):
	for i in range(0, density):
		var x = randi_range(v3i.x, v3f.x)
		var y = randi_range(v3i.y, v3f.y)
		if randi()%2==0:
			emit_signal("alter_terrain", "hills", Tag.default, Vector3i(x, y, 0), randi()%14)
		else:
			emit_signal("alter_terrain", "plains", Tag.default, Vector3i(x, y, 0), randi()%14)
		emit_signal("alter_terrain", "fill", Tag.water, 4, null)
