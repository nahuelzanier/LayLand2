extends Node2D

@onready var render = $Render
@onready var enviroment = $Enviroment
@onready var preload_scenes = $PreloadScenes
@onready var camera_state_manager = $CameraStateManager
@onready var map_manager = $MapManager

var x_range_init = GameGlobal.x_range
var y_range_init = GameGlobal.y_range
var z_range = range(0,17)

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	GameGlobal.player_render = $Render/PlayerRender
	GameGlobal.main = self

	for x in x_range_init:
		for y in y_range_init:
			create_column(x, y)

	for x in x_range_init:
		for y in y_range_init:
			for z in z_range:
				block_generator_01(x, y, z)

	for x in x_range_init:
		for y in y_range_init:
			for z in z_range:
				if GameGlobal.tag_map.has(Vector3i(x, y, z)):
					GameGlobal.create_tile(preload_scenes.PRELOAD[GameGlobal.tag_map[Vector3i(x,y,z)]], Vector3i(x,y,z))

	for x in x_range_init:
		for y in y_range_init:
			for z in z_range:
				if GameGlobal.render_layers[Vector2i(x,y)].column[z].has_block:
					GameGlobal.render_layers[Vector2i(x,y)].column[z].block.on_creation()

	var player = GameGlobal.preload_scenes.PLAYER.instantiate()
	$Render/PlayerRender.add_child(player)

func update_map(iso_dir):
	var x_range = GameGlobal.x_range
	var y_range = GameGlobal.y_range
	if iso_dir.x<0:
		GameGlobal.displacement -= Vector2i(1,0)
		for y in y_range:
			create_column(x_range[0]+iso_dir.x, y)
			for z in z_range:
				block_generator_01(x_range[0]+iso_dir.x, y, z)
				if GameGlobal.tag_map.has(Vector3i(x_range[0]+iso_dir.x, y, z)):
					GameGlobal.create_tile(preload_scenes.PRELOAD[GameGlobal.tag_map[Vector3i(x_range[0]+iso_dir.x, y, z)]], Vector3i(x_range[0]+iso_dir.x, y, z))
					var shift_pos = IsometricConverter.vector_shift(Vector3i(x_range[0]+iso_dir.x, y, z))
					GameGlobal.render_layers[Vector2i(x_range[0]+iso_dir.x, y)].position = IsometricConverter._iso_to_pos(shift_pos)
			GameGlobal.render_layers[Vector2i(x_range[-1], y)].queue_free()
			GameGlobal.render_layers.erase(Vector2i(x_range[-1], y))
		GameGlobal.x_range.pop_back()
		GameGlobal.x_range.push_front(x_range[0]+iso_dir.x)
	if iso_dir.x>0:
		GameGlobal.displacement += Vector2i(1,0)
		for y in y_range:
			create_column(x_range[-1]+iso_dir.x, y)
			for z in z_range:
				block_generator_01(x_range[-1]+iso_dir.x, y, z)
				if GameGlobal.tag_map.has(Vector3i(x_range[-1]+iso_dir.x, y, z)):
					GameGlobal.create_tile(preload_scenes.PRELOAD[GameGlobal.tag_map[Vector3i(x_range[-1]+iso_dir.x, y, z)]], Vector3i(x_range[-1]+iso_dir.x, y, z))
					var shift_pos = IsometricConverter.vector_shift(Vector3i(x_range[-1]+iso_dir.x, y, z))
					GameGlobal.render_layers[Vector2i(x_range[-1]+iso_dir.x, y)].position = IsometricConverter._iso_to_pos(shift_pos)
			GameGlobal.render_layers[Vector2i(x_range[0], y)].queue_free()
			GameGlobal.render_layers.erase(Vector2i(x_range[0], y))
		GameGlobal.x_range.pop_front()
		GameGlobal.x_range.push_back(x_range[-1]+iso_dir.x)
	if iso_dir.y<0:
		GameGlobal.displacement -= Vector2i(0,1)
		for x in x_range:
			create_column(x, y_range[0]+iso_dir.y)
			for z in z_range:
				block_generator_01(x, y_range[0]+iso_dir.y, z)
				if GameGlobal.tag_map.has(Vector3i(x, y_range[0]+iso_dir.y, z)):
					GameGlobal.create_tile(preload_scenes.PRELOAD[GameGlobal.tag_map[Vector3i(x, y_range[0]+iso_dir.y, z)]], Vector3i(x, y_range[0]+iso_dir.y, z))
					var shift_pos = IsometricConverter.vector_shift(Vector3i(x, y_range[0]+iso_dir.y, z))
					GameGlobal.render_layers[Vector2i(x, y_range[0]+iso_dir.y)].position = IsometricConverter._iso_to_pos(shift_pos)
			GameGlobal.render_layers[Vector2i(x, y_range[-1])].queue_free()
			GameGlobal.render_layers.erase(Vector2i(x, y_range[-1]))
		GameGlobal.y_range.pop_back()
		GameGlobal.y_range.push_front(y_range[0]+iso_dir.y)
	if iso_dir.y>0:
		GameGlobal.displacement += Vector2i(0,1)
		for x in x_range:
			create_column(x, y_range[-1]+iso_dir.y)
			for z in z_range:
				block_generator_01(x, y_range[-1]+iso_dir.y, z)
				if GameGlobal.tag_map.has(Vector3i(x, y_range[-1]+iso_dir.y, z)):
					GameGlobal.create_tile(preload_scenes.PRELOAD[GameGlobal.tag_map[Vector3i(x, y_range[-1]+iso_dir.y, z)]], Vector3i(x, y_range[-1]+iso_dir.y, z))
					var shift_pos = IsometricConverter.vector_shift(Vector3i(x, y_range[-1]+iso_dir.y, z))
					GameGlobal.render_layers[Vector2i(x, y_range[-1]+iso_dir.y)].position = IsometricConverter._iso_to_pos(shift_pos)
			GameGlobal.render_layers[Vector2i(x, y_range[0])].queue_free()
			GameGlobal.render_layers.erase(Vector2i(x, y_range[0]))
		GameGlobal.y_range.pop_front()
		GameGlobal.y_range.push_back(y_range[-1]+iso_dir.y)


func create_column(x, y):
	var column = preload_scenes.COLUMN_GAME.instantiate()
	column.iso_pos = Vector2i(x, y)
	GameGlobal.render_layers[Vector2i(x,y)] = column
	column.position = IsometricConverter._iso_to_pos(Vector2i(x,y))
	render.add_child(column)
	GameGlobal.create_tile(preload_scenes.BLOCK_EMPTY, Vector3i(x,y,-1))
	GameGlobal.create_tile(preload_scenes.BLOCK_EMPTY, Vector3i(x,y,17))

func block_generator_01(x, y, z):
	var r = randi()%800
	#if r==0:
		#map_manager.sphere("water", Vector3i(x, y, z), randi()%3+1)
	if r==1:
		map_manager.sphere("default", Vector3i(x, y, z), randi()%3+1)
	if z<5:
		var s = randi()%1
		if s == 0:
			GameGlobal.tag_map[Vector3i(x, y, z)] = "default"
		#if s == 1:
			#GameGlobal.tag_map[Vector3i(x, y, z)] = "water"
	
