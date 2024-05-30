extends Node

@onready var terrains = $Terrains
@onready var hills = $Terrains/Hills
@onready var dunes = $Terrains/Dunes
@onready var stone = $Terrains/Stone
@onready var random = $Terrains/Random


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
		map[0].push_back([[],[]])  #y_neg, y_pos
		map[1].push_back([[],[]])  #y_neg, y_pos
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
	for x in range(-w, w):
		for y in range(-w, w):
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


