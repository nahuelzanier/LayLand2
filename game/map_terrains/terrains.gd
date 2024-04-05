extends Node

func circle(block_tag, v3, r, roughness):
	for x in range(-r, r):
		for y in range(-r, r):
			if abs(x)<GameGlobal.map_width && abs(y)<GameGlobal.map_width:
				if Vector2(x, y).length() < r*roughness:
					GameGlobal.map_manager.set_tile(v3 + Vector3i(x, y, 0), block_tag)

func hills(block_tag, v3, r):
	for z in range(v3.z, v3.z+r):
		circle(block_tag, Vector3i(v3.x, v3.y, z), r, 0.9)
		r -= 1
		if r <= 1: break

func rocky(block_tag, v3, r):
	for z in range(v3.z, v3.z+r):
		circle(block_tag, Vector3i(v3.x, v3.y, z), r, 0.7)
		r -= 1
		if r <= 1: break

func plains(block_tag, v3, r):
	for z in range(v3.z, v3.z+r):
		circle(block_tag, Vector3i(v3.x, v3.y, z), r, 0.9)
		r -= 2
		if r <= 1: break

func fill(block_tag, height, _extra):
	var w = GameGlobal.map_width
	for x in range(-w, w):
		for y in range(-w, w):
			var col = GameGlobal.map_manager.get_column(Vector2i(x, y))
			for z in range(height, -1, -1):
				if col[z] != Tag.empty: break
				else: col[z] = block_tag

func _on_alter_terrain(function, arg1, arg2, arg3):
	call(function, arg1, arg2, arg3)
