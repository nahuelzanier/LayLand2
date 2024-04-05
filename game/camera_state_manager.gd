extends Node

func _ready():
	GameGlobal.camera_manager = self

func _process(delta):
	if Input.is_action_just_pressed("right_trigger"):
		GameGlobal.camera_angle = (GameGlobal.camera_angle+4+1)%4
		GameGlobal.player.climbing = true
		GameGlobal.player.reset_position = true
		for x in GameGlobal.x_range:
			for y in GameGlobal.y_range:
				var vec = IsometricConverter.vector_shift(Vector2i(x,y))
				GameGlobal.render_layers[Vector2i(x,y)].position = IsometricConverter._iso_to_pos(vec)
		player_position_right()

	if Input.is_action_just_pressed("left_trigger"):
		GameGlobal.camera_angle = (GameGlobal.camera_angle+4-1)%4
		GameGlobal.player.climbing = true
		GameGlobal.player.reset_position = true
		for x in GameGlobal.x_range:
			for y in GameGlobal.y_range:
				var vec = IsometricConverter.vector_shift(Vector2i(x,y))
				GameGlobal.render_layers[Vector2i(x,y)].position = IsometricConverter._iso_to_pos(vec)
		player_position_left()

func player_position_right():
	var p_iso = GameGlobal.player.iso_pos()
	if GameGlobal.camera_angle == 0:
		p_iso = Vector2i(-p_iso.y, p_iso.x)
	if GameGlobal.camera_angle == 1:
		p_iso = Vector2i(-p_iso.y, p_iso.x)
	if GameGlobal.camera_angle == 2:
		p_iso = Vector2i(-p_iso.y, p_iso.x)
	if GameGlobal.camera_angle == 3:
		p_iso = Vector2i(-p_iso.y, p_iso.x)
	GameGlobal.player.position = IsometricConverter._iso_to_pos(p_iso)

func player_position_left():
	var p_iso = GameGlobal.player.iso_pos()
	if GameGlobal.camera_angle == 0:
		p_iso = Vector2i(p_iso.y, -p_iso.x)
	if GameGlobal.camera_angle == 1:
		p_iso = Vector2i(p_iso.y, -p_iso.x)
	if GameGlobal.camera_angle == 2:
		p_iso = Vector2i(p_iso.y, -p_iso.x)
	if GameGlobal.camera_angle == 3:
		p_iso = Vector2i(p_iso.y, -p_iso.x)
	GameGlobal.player.position = IsometricConverter._iso_to_pos(p_iso)

func update_map(iso_dir):
	var x_range = GameGlobal.x_range
	var y_range = GameGlobal.y_range
	var z_range = GameGlobal.z_range
	if iso_dir.x<0:
		if not IsometricConverter.vector_shift_rev(GameGlobal.player.iso_pos()).x >= x_range[0]-GameGlobal.map_min:
			GameGlobal.displacement -= Vector2i(1,0)
			for y in y_range:
				if x_range[0]>-GameGlobal.map_width+1:
					create_column(x_range[0]+iso_dir.x, y)
					for z in z_range:
						GameGlobal.render_block(Vector3i(x_range[0]+iso_dir.x, y, z))
						var shift_pos = IsometricConverter.vector_shift(Vector3i(x_range[0]+iso_dir.x, y, z))
						GameGlobal.render_layers[Vector2i(x_range[0]+iso_dir.x, y)].position = IsometricConverter._iso_to_pos(shift_pos)
					GameGlobal.render_layers[Vector2i(x_range[-1], y)].delete_column()
			if x_range[0]>-GameGlobal.map_width+1: 
				GameGlobal.x_range.pop_back()
				GameGlobal.x_range.push_front(x_range[0]+iso_dir.x)
	if iso_dir.x>0:
		if not IsometricConverter.vector_shift_rev(GameGlobal.player.iso_pos()).x <= x_range[-1]-GameGlobal.map_max:
			GameGlobal.displacement += Vector2i(1,0)
			for y in y_range:
				if x_range[-1]<GameGlobal.map_width-1:
					create_column(x_range[-1]+iso_dir.x, y)
					for z in z_range:
						GameGlobal.render_block(Vector3i(x_range[-1]+iso_dir.x, y, z))
						var shift_pos = IsometricConverter.vector_shift(Vector3i(x_range[-1]+iso_dir.x, y, z))
						GameGlobal.render_layers[Vector2i(x_range[-1]+iso_dir.x, y)].position = IsometricConverter._iso_to_pos(shift_pos)
					GameGlobal.render_layers[Vector2i(x_range[0], y)].delete_column()
			if x_range[-1]<GameGlobal.map_width-1:
				GameGlobal.x_range.pop_front()
				GameGlobal.x_range.push_back(x_range[-1]+iso_dir.x)
	if iso_dir.y<0:
		if not IsometricConverter.vector_shift_rev(GameGlobal.player.iso_pos()).y >= y_range[0]-GameGlobal.map_min:
			GameGlobal.displacement -= Vector2i(0,1)
			for x in x_range:
				if y_range[0]>-GameGlobal.map_width+1:
					create_column(x, y_range[0]+iso_dir.y)
					for z in z_range:
						GameGlobal.render_block(Vector3i(x, y_range[0]+iso_dir.y, z))
						var shift_pos = IsometricConverter.vector_shift(Vector3i(x, y_range[0]+iso_dir.y, z))
						GameGlobal.render_layers[Vector2i(x, y_range[0]+iso_dir.y)].position = IsometricConverter._iso_to_pos(shift_pos)
					GameGlobal.render_layers[Vector2i(x, y_range[-1])].delete_column()
			if y_range[0]>-GameGlobal.map_width+1:
				GameGlobal.y_range.pop_back()
				GameGlobal.y_range.push_front(y_range[0]+iso_dir.y)
	if iso_dir.y>0:
		if not IsometricConverter.vector_shift_rev(GameGlobal.player.iso_pos()).y <= y_range[-1]-GameGlobal.map_max:
			GameGlobal.displacement += Vector2i(0,1)
			for x in x_range:
				if y_range[-1]<GameGlobal.map_width-1:
					create_column(x, y_range[-1]+iso_dir.y)
					for z in z_range:
						GameGlobal.render_block(Vector3i(x, y_range[-1]+iso_dir.y, z))
						var shift_pos = IsometricConverter.vector_shift(Vector3i(x, y_range[-1]+iso_dir.y, z))
						GameGlobal.render_layers[Vector2i(x, y_range[-1]+iso_dir.y)].position = IsometricConverter._iso_to_pos(shift_pos)
					GameGlobal.render_layers[Vector2i(x, y_range[0])].delete_column()
			if y_range[-1]<GameGlobal.map_width-1:
				GameGlobal.y_range.pop_front()
				GameGlobal.y_range.push_back(y_range[-1]+iso_dir.y)

func create_column(x, y):
	var column = GameGlobal.preload_scenes.COLUMN_GAME.instantiate()
	column.iso_pos = Vector2i(x, y)
	GameGlobal.render_layers[Vector2i(x,y)] = column
	column.position = IsometricConverter._iso_to_pos(Vector2i(x,y))
	GameGlobal.render.add_child(column)
