extends Node2D

@onready var render = $Render
@onready var preload_scenes = $PreloadScenes
@onready var camera_state_manager = $CameraStateManager
@onready var map_manager = $MapManager

var x_range_init = GameGlobal.x_range
var y_range_init = GameGlobal.y_range
var z_range = range(-1,GameGlobal.max_z_value+1)

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	GameGlobal.player_render = $Render/PlayerRender
	GameGlobal.main = self

	map_manager.generate_map(50, 50, GameGlobal.max_z_value+1)

	for x in x_range_init:
		for y in y_range_init:
			create_column(x, y)
			for z in z_range:
				GameGlobal.render_block(Vector3i(x, y, z))

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
				if GameGlobal.map.has(Vector3i(x_range[0]+iso_dir.x, y, z)):
					GameGlobal.render_block(Vector3i(x_range[0]+iso_dir.x, y, z))
					var shift_pos = IsometricConverter.vector_shift(Vector3i(x_range[0]+iso_dir.x, y, z))
					GameGlobal.render_layers[Vector2i(x_range[0]+iso_dir.x, y)].position = IsometricConverter._iso_to_pos(shift_pos)
			GameGlobal.render_layers[Vector2i(x_range[-1], y)].delete_column()
		GameGlobal.x_range.pop_back()
		GameGlobal.x_range.push_front(x_range[0]+iso_dir.x)
	if iso_dir.x>0:
		GameGlobal.displacement += Vector2i(1,0)
		for y in y_range:
			create_column(x_range[-1]+iso_dir.x, y)
			for z in z_range:
				if GameGlobal.map.has(Vector3i(x_range[-1]+iso_dir.x, y, z)):
					GameGlobal.render_block(Vector3i(x_range[-1]+iso_dir.x, y, z))
					var shift_pos = IsometricConverter.vector_shift(Vector3i(x_range[-1]+iso_dir.x, y, z))
					GameGlobal.render_layers[Vector2i(x_range[-1]+iso_dir.x, y)].position = IsometricConverter._iso_to_pos(shift_pos)
			GameGlobal.render_layers[Vector2i(x_range[0], y)].delete_column()
		GameGlobal.x_range.pop_front()
		GameGlobal.x_range.push_back(x_range[-1]+iso_dir.x)
	if iso_dir.y<0:
		GameGlobal.displacement -= Vector2i(0,1)
		for x in x_range:
			create_column(x, y_range[0]+iso_dir.y)
			for z in z_range:
				if GameGlobal.map.has(Vector3i(x, y_range[0]+iso_dir.y, z)):
					GameGlobal.render_block(Vector3i(x, y_range[0]+iso_dir.y, z))
					var shift_pos = IsometricConverter.vector_shift(Vector3i(x, y_range[0]+iso_dir.y, z))
					GameGlobal.render_layers[Vector2i(x, y_range[0]+iso_dir.y)].position = IsometricConverter._iso_to_pos(shift_pos)
			GameGlobal.render_layers[Vector2i(x, y_range[-1])].delete_column()
		GameGlobal.y_range.pop_back()
		GameGlobal.y_range.push_front(y_range[0]+iso_dir.y)
	if iso_dir.y>0:
		GameGlobal.displacement += Vector2i(0,1)
		for x in x_range:
			create_column(x, y_range[-1]+iso_dir.y)
			for z in z_range:
				if GameGlobal.map.has(Vector3i(x, y_range[-1]+iso_dir.y, z)):
					GameGlobal.render_block(Vector3i(x, y_range[-1]+iso_dir.y, z))
					var shift_pos = IsometricConverter.vector_shift(Vector3i(x, y_range[-1]+iso_dir.y, z))
					GameGlobal.render_layers[Vector2i(x, y_range[-1]+iso_dir.y)].position = IsometricConverter._iso_to_pos(shift_pos)
			GameGlobal.render_layers[Vector2i(x, y_range[0])].delete_column()
		GameGlobal.y_range.pop_front()
		GameGlobal.y_range.push_back(y_range[-1]+iso_dir.y)

func create_column(x, y):
	var column = preload_scenes.COLUMN_GAME.instantiate()
	column.iso_pos = Vector2i(x, y)
	GameGlobal.render_layers[Vector2i(x,y)] = column
	column.position = IsometricConverter._iso_to_pos(Vector2i(x,y))
	render.add_child(column)

