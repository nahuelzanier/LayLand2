extends Node2D

func _process(delta):
	if Input.is_action_just_pressed("right_trigger"):
		GameGlobal.camera_angle = (GameGlobal.camera_angle+4+1)%4
		for x in GameGlobal.x_range:
			for y in GameGlobal.y_range:
				var vec = IsometricConverter.vector_shift(Vector2i(x,y))
				GameGlobal.render_layers[Vector2i(x, y)].position = IsometricConverter._iso_to_pos(vec)
		player_position_right()

	if Input.is_action_just_pressed("left_trigger"):
		GameGlobal.camera_angle = (GameGlobal.camera_angle+4-1)%4
		var dict = {}
		for x in GameGlobal.x_range:
			for y in GameGlobal.y_range:
				var vec = IsometricConverter.vector_shift(Vector2i(x,y))
				GameGlobal.render_layers[Vector2i(x, y)].position = IsometricConverter._iso_to_pos(vec)
		player_position_left()

func player_position_right():
	var p_iso = GameGlobal.player.iso_pos()
	if GameGlobal.camera_angle == 0:
		p_iso = Vector2(-p_iso.y, p_iso.x)
	if GameGlobal.camera_angle == 1:
		p_iso = Vector2(-p_iso.y, p_iso.x)
	if GameGlobal.camera_angle == 2:
		p_iso = Vector2(-p_iso.y, p_iso.x)
	if GameGlobal.camera_angle == 3:
		p_iso = Vector2(-p_iso.y, p_iso.x)
	GameGlobal.player.position = IsometricConverter._iso_to_pos(p_iso)

func player_position_left():
	var p_iso = GameGlobal.player.iso_pos()
	if GameGlobal.camera_angle == 0:
		p_iso = Vector2(p_iso.y, -p_iso.x)
	if GameGlobal.camera_angle == 1:
		p_iso = Vector2(p_iso.y, -p_iso.x)
	if GameGlobal.camera_angle == 2:
		p_iso = Vector2(p_iso.y, -p_iso.x)
	if GameGlobal.camera_angle == 3:
		p_iso = Vector2(p_iso.y, -p_iso.x)
	GameGlobal.player.position = IsometricConverter._iso_to_pos(p_iso)
