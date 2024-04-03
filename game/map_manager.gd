extends Node2D

var map = GameGlobal.map
var blocks = [
	"default", 
	"water"
]

func generate_map(xr, yr, zr):
	for x in range(-xr, xr):
		for y in range(-yr, yr):
			for z in range(-1, zr):
				if z==-1 or z==zr:
					GameGlobal.create_tile("empty", Vector3i(x,y,z))
				elif z<5:
					GameGlobal.create_tile("default", Vector3i(x,y,z))
				else:
					var r = randi()%1000
					if r==0:
						sphere("default", Vector3i(x,y,z), randi()%5)
					#if r==1:
						#sphere("water", Vector3i(x,y,z), randi()%5)

func block_generator_proc(dir, x, y, z):
	if z<6:
		var s = randi()%1
		if s == 0:
			map[Vector3i(x, y, z)] = "default"

func square(block_tag, v3, r):
	for x in range(-r,r+1):
		for y in range(-r,r+1):
			for z in range(0,1):
				map[v3 + Vector3i(x, y, 0)] = block_tag

func cube(block_tag, v3, r):
	for x in range(-r,r):
		for y in range(-r,r):
			for z in range(-r,r):
				if not map.has(v3 + Vector3i(x, y, z)):
					map[v3 + Vector3i(x, y, z)] = block_tag

func circle(block_tag, v3, r):
	for x in range(-r, r):
		for y in range(-r, r):
				if Vector2(x, y).length() < r:
					map[v3 + Vector3i(x, y, 0)] = block_tag

func semi_sphere(block_tag, v3, r):
	for x in range(-r, r*4):
		for y in range(-r, r*4):
			for z in range(0, floor(r/2)):
				if not map.has(v3 + Vector3i(x, y, z)):
					if Vector3(x, y, z).length() < r:
						map[v3 + Vector3i(x, y, z)] = block_tag

func sphere(block_tag, v3, r):
	for x in range(-r, r):
		for y in range(-r, r):
			for z in range(-r, r):
				if z<GameGlobal.max_z_value && z>=0:
					if Vector3(x, y, z).length() < r:
						if not map.has(v3 + Vector3i(x, y, z)):
							GameGlobal.create_tile(block_tag, v3 + Vector3i(x, y, z))
