extends Node2D

var map = GameGlobal.tag_map
var blocks = [
	"default", 
	"water"
]

func cube(block_tag, v3, r):
	for x in range(-r,r):
		for y in range(-r,r):
			for z in range(-r,r):
				if not map.has(v3 + Vector3i(x, y, z)):
					map[v3 + Vector3i(x, y, z)] = block_tag

func sphere(block_tag, v3, r):
	for x in range(-r, r):
		for y in range(-r, r):
			for z in range(-r, r):
				if not map.has(v3 + Vector3i(x, y, z)):
					if Vector3(x, y, z).length() < r:
						map[v3 + Vector3i(x, y, z)] = block_tag
