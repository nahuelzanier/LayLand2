extends Node2D

func _process(delta):
	if Input.is_action_just_pressed("right_trigger"):
		GameGlobal.camera_angle = (GameGlobal.camera_angle+4+1)%4
		center_columns()
		for x in GameGlobal.x_range_base:
			for y in GameGlobal.y_range_base:
				var vec = IsometricConverter.vector_shift(Vector2i(x,y))
				GameGlobal.render_layers[Vector2i(x, y)].position = IsometricConverter._iso_to_pos(vec)

	if Input.is_action_just_pressed("left_trigger"):
		GameGlobal.camera_angle = (GameGlobal.camera_angle+4-1)%4
		center_columns()
		for x in GameGlobal.x_range_base:
			for y in GameGlobal.y_range_base:
				var vec = IsometricConverter.vector_shift(Vector2i(x,y))
				GameGlobal.render_layers[Vector2i(x, y)].position = IsometricConverter._iso_to_pos(vec)

#func player_position_right():
	#var p_iso = GameGlobal.player.iso_pos()
	#if GameGlobal.camera_angle == 0:
		#p_iso = Vector2i(-p_iso.y, p_iso.x)
	#if GameGlobal.camera_angle == 1:
		#p_iso = Vector2i(-p_iso.y, p_iso.x)
	#if GameGlobal.camera_angle == 2:
		#p_iso = Vector2i(-p_iso.y, p_iso.x)
	#if GameGlobal.camera_angle == 3:
		#p_iso = Vector2i(-p_iso.y, p_iso.x)
	#GameGlobal.player.position = IsometricConverter._iso_to_pos(p_iso)
#
#func player_position_left():
	#var p_iso = GameGlobal.player.iso_pos()
	#if GameGlobal.camera_angle == 0:
		#p_iso = Vector2i(p_iso.y, -p_iso.x)
	#if GameGlobal.camera_angle == 1:
		#p_iso = Vector2i(p_iso.y, -p_iso.x)
	#if GameGlobal.camera_angle == 2:
		#p_iso = Vector2i(p_iso.y, -p_iso.x)
	#if GameGlobal.camera_angle == 3:
		#p_iso = Vector2i(p_iso.y, -p_iso.x)
	#GameGlobal.player.position = IsometricConverter._iso_to_pos(p_iso)

func center_columns():
	var dict = {}
	for x in GameGlobal.x_range:
		for y in GameGlobal.y_range:
			var vec = GameGlobal.displacement
			dict[Vector2i(x-vec.x, y-vec.y)] = GameGlobal.render_layers[Vector2i(x, y)]
			GameGlobal.render_layers.erase(Vector2i(x, y))
			dict[Vector2i(x-vec.x, y-vec.y)].iso_pos = Vector2i(x-vec.x, y-vec.y)
	GameGlobal.render_layers = dict
	GameGlobal.displacement = Vector2i(0,0)
	GameGlobal.player.climbing = true
	GameGlobal.player.reset_position = true
	GameGlobal.x_range = range(GameGlobal.map_min, GameGlobal.map_max)
	GameGlobal.y_range = range(GameGlobal.map_min, GameGlobal.map_max)
