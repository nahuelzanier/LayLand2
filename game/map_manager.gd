extends Node2D

var map = {}

var blocks = [
	"empty",
	"default", 
	"water"
]

func _ready():
	GameGlobal.map = map

func set_tile(vector3, data):
	map[vector3] = data

func switch_tiles(v3_a, v3_b):
	var temp = map[v3_a]
	map[v3_a] = map[v3_b]
	map[v3_b] = temp

func generate_map(xr, yr, zr):
	for x in range(-xr, xr):
		for y in range(-yr, yr):
			for z in range(-1, zr):
				set_tile(Vector3i(x,y,z), Tag.empty)
				if z>-1 and z<5:
					set_tile(Vector3i(x,y,z), Tag.default)
				else:
					var r = randi()%1000
					if r==0:
						sphere(Tag.default, Vector3i(x,y,z), randi()%5)

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
				if v3.z+z<=GameGlobal.max_z_value && v3.z+z>=0:
					if Vector3(x, y, z).length() < r:
						set_tile(v3 + Vector3i(x,y,z), Tag.default)
