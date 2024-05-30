extends Node

signal alter_terrain(function, tag, vector3i, range)

func generate_terrain(density, v3i, v3f):
	for i in range(0, density):
		var x = randi_range(v3i.x, v3f.x)
		var y = randi_range(v3i.y, v3f.y)
		emit_signal("alter_terrain", "fill", Tag.sand, 3, null)
		if randi()%2==0:
			emit_signal("alter_terrain", "hills", Tag.sand, Vector3i(x, y, 4), randi()%9)
		else:
			emit_signal("alter_terrain", "plains", Tag.sand, Vector3i(x, y, 4), randi()%9)
		if randi()%12==0:
			emit_signal("alter_terrain", "palmtree", Tag.wood_piece, Vector2i(x, y),randi()%6+10)
