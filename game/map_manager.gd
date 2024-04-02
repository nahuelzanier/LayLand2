extends Node2D

var map = GameGlobal.tag_map
var blocks = [
	"default", 
	"water"
]

func block_generator_proc(dir, x, y, z):
	var r = randi()%1000
	if r==0:
		var wid = 3
		circle("default", Vector3i(x+dir.x*10, y+dir.y*10, 6), wid+6)
		if randi()%4 < 3:
			circle("default", Vector3i(x+dir.x*10, y+dir.y*10, 7), wid+5)
			if randi()%4 < 3:
				circle("default", Vector3i(x+dir.x*10, y+dir.y*10, 8), wid+4)
				if randi()%4 < 3:
					circle("default",Vector3i(x+dir.x*10, y+dir.y*10, 9), wid+3)
					if randi()%4 < 3:
						circle("default", Vector3i(x+dir.x*10, y+dir.y*10, 10), wid+2)
						if randi()%4 < 3:
							circle("default", Vector3i(x+dir.x*10, y+dir.y*10, 11), wid+1)
							if randi()%4 < 3:
								circle("default", Vector3i(x+dir.x*10, y+dir.y*10, 12), wid)
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
				if not map.has(v3 + Vector3i(x, y, z)):
					if Vector3(x, y, z).length() < r:
						map[v3 + Vector3i(x, y, z)] = block_tag
