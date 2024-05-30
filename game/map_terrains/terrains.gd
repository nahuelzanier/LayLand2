extends Node

#SHAPES
func circle(block_tag, v3, r, roughness):
	for x in range(-r, r):
		for y in range(-r, r):
			if abs(x)<GameGlobal.map_width && abs(y)<GameGlobal.map_width:
				if Vector2(x, y).length() < r*roughness:
					GameGlobal.map_manager.set_tile(v3 + Vector3i(x, y, 0), block_tag)

func column(block_tag, vector2i, height):
	var col = GameGlobal.map_manager.get_column(vector2i)
	for z in range(height, -1, -1):
		if col[z]!=Tag.empty: break
		elif col[z]!=Tag.no_access: col[z] = block_tag

#TERRAIN
func hills(block_tag, v3, r):
	for z in range(v3.z, v3.z+r):
		if z > 0:
			circle(block_tag, Vector3i(v3.x, v3.y, z), r, 0.9)
			r -= 1
			if r <= 1: break

func rocky(block_tag, v3, r):
	for z in range(v3.z, v3.z+r):
		if z > 0:
			circle(block_tag, Vector3i(v3.x, v3.y, z), r, 0.7)
			r -= 1
			if r <= 1: break

func plains(block_tag, v3, r):
	for z in range(v3.z, v3.z+r):
		if z > 0:
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

func palmtree(_extra, vector2i, height):
	var col = GameGlobal.map_manager.get_column(vector2i)
	for z in range(height, -1, -1):
		if z == height:
			var leav = [Vector2i(0,1), Vector2i(0,-1), Vector2i(1,0), Vector2i(-1,0)]
			for v in leav:
				GameGlobal.map_manager.set_tile(Vector3i(vector2i.x+v.x, vector2i.y+v.y, z), Tag.palm_leaves)
				GameGlobal.map_manager.set_tile(Vector3i(vector2i.x+2*v.x, vector2i.y+2*v.y, z+1), Tag.palm_leaves)
				GameGlobal.map_manager.set_tile(Vector3i(vector2i.x+3*v.x, vector2i.y+3*v.y, z), Tag.palm_leaves)
				GameGlobal.map_manager.set_tile(Vector3i(vector2i.x+v.x, vector2i.y+v.y, z+1), Tag.palm_leaves)
				GameGlobal.map_manager.set_tile(Vector3i(vector2i.x+2*v.x, vector2i.y+2*v.y, z+2), Tag.palm_leaves)
				GameGlobal.map_manager.set_tile(Vector3i(vector2i.x+3*v.x, vector2i.y+3*v.y, z+1), Tag.palm_leaves)
		if col[z]!=Tag.empty: break
		elif col[z]!=Tag.no_access: col[z] = Tag.wood_piece

func _on_alter_terrain(function, arg1, arg2, arg3):
	call(function, arg1, arg2, arg3)

