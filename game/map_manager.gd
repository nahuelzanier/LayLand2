extends Node

@onready var terrains = $Terrains
@onready var hills = $Terrains/Hills

var nodes = [
	Tag.empty,
	Tag.default
]

var map = [
	[], #x_neg
	[]  #x_pos
]

func _ready():
	GameGlobal.map = map
	GameGlobal.map_manager = self

	var w = GameGlobal.map_width
	for x in range(0, w):
		map[0].push_back([[],[]])
		map[1].push_back([[],[]])
		for y in range(0, w):
			var res = Vector2i(0,0)
			if x < 0: res.x = 0
			else: res.x = 1
			if y < 0: res.y = 0
			else: res.y = 1
			map[0][x][0].push_back([])
			map[1][x][0].push_back([])
			map[0][x][1].push_back([])
			map[1][x][1].push_back([])
			for z in range(0, GameGlobal.max_z_value):
				map[0][x][0][y].push_back(Tag.empty)
				map[1][x][0][y].push_back(Tag.empty)
				map[0][x][1][y].push_back(Tag.empty)
				map[1][x][1][y].push_back(Tag.empty)
			map[0][x][0][y].push_back(Tag.no_access)
			map[1][x][0][y].push_back(Tag.no_access)
			map[0][x][1][y].push_back(Tag.no_access)
			map[1][x][1][y].push_back(Tag.no_access)
	for x in range(0, w):
		for y in range(0, w):
			set_tile(Vector3i(x, y, 0), Tag.no_access)

func generate_map(): pass

func set_tile(v3i, data):
	if abs(v3i.x) < GameGlobal.map_width && abs(v3i.y) < GameGlobal.map_width:
		var res = Vector2i(0,0)
		if v3i.x < 0: res.x = 0
		else: res.x = 1
		if v3i.y < 0: res.y = 0
		else: res.y = 1
		map[res.x][v3i.x][res.y][v3i.y][v3i.z] = data

func get_tile(v3i):
	var res = Vector2i(0,0)
	if v3i.x < 0: res.x = 0
	else: res.x = 1
	if v3i.y < 0: res.y = 0
	else: res.y = 1
	return map[res.x][v3i.x][res.y][v3i.y][v3i.z]

func switch_tiles(v3_a, v3_b):
	var block_a = get_tile(v3_a)
	var block_b = get_tile(v3_b)
	set_tile(v3_a, block_b)
	set_tile(v3_b, block_a)

func set_col_tile(column, z, data):
	column[z] = data

func get_col_tile(column, z):
	return column[z]

func get_column(v2i):
	var res = Vector2i(0,0)
	if v2i.x < 0: res.x = 0
	else: res.x = 1
	if v2i.y < 0: res.y = 0
	else: res.y = 1
	return map[res.x][v2i.x][res.y][v2i.y]

func switch_column_tiles(v2i, z1, z2):
	var col = get_column(v2i)
	var block_a = col[z1]
	var block_b = col[z2]
	col[z1] = block_b
	col[z2] = block_a


#func square(tag, v3, r):
	#for x in range(-r, r):
		#for y in range(-r, r):
			#if abs(v3.x + x)<GameGlobal.map_width && abs(v3.y + y)<GameGlobal.map_width:
				#set_tile(v3 + Vector3i(x, y, 0), tag)

#func cube(block_tag, v3, r):
	#for x in range(-r,r):
		#for y in range(-r,r):
			#for z in range(-r,r):
				#if v3.z+z<GameGlobal.max_z_value && v3.z+z>=0:
					#map[v3 + Vector3i(x, y, z)] = block_tag


#
#func semi_sphere(block_tag, v3, r):
	#for x in range(-r, r*4):
		#for y in range(-r, r*4):
			#for z in range(0, floor(r/2)):
				#if not map.has(v3 + Vector3i(x, y, z)):
					#if Vector3(x, y, z).length() < r:
						#map[v3 + Vector3i(x, y, z)] = block_tag
#
#func sphere(block_tag, v3, r):
	#for x in range(-r, r):
		#for y in range(-r, r):
			#for z in range(-r, r):
				#if v3.z+z<GameGlobal.max_z_value && v3.z+z>=0:
					#if Vector3(x, y, z).length() < r*0.9:
						#set_tile(v3 + Vector3i(x,y,z), Tag.default)

#func get_seed(v3i):
	#var vec01 = Vector2(float(v3i.x), float(v3i.y)).distance_to(Vector2(float(GameGlobal.seed_vecs[0].x), float(GameGlobal.seed_vecs[0].y)))
	#var vec02 = Vector2(float(v3i.x), float(v3i.z)).distance_to(Vector2(float(GameGlobal.seed_vecs[1].x), float(GameGlobal.seed_vecs[1].y)))
	#var vec03 = Vector2(float(v3i.y), float(v3i.z)).distance_to(Vector2(float(GameGlobal.seed_vecs[2].x), float(GameGlobal.seed_vecs[1].y)))
	#var rx = GameGlobal.seed[-v3i.x+v3i.y]%500
	#var ry = GameGlobal.seed[v3i.y-v3i.x]%500
	#return (
		#(GameGlobal.seed[int(vec01)+1] + GameGlobal.seed[int(vec02)+2] + GameGlobal.seed[int(vec03)+3]) % 2
		#+ GameGlobal.seed[(rx + ry)%500]
		#+ GameGlobal.seed[floor(v3i).length()]
		#+ GameGlobal.seed[v3i.x + v3i.y + v3i.z]
	#)
