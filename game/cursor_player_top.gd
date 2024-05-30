extends Node2D

func _process(delta):
	var mouse_pos = get_global_mouse_position() #+ Vector2(0, (GameGlobal.player.current_colission_layer-2)*IsometricConverter.ISO_HEIGHT/2)
	var iso_mouse = IsometricConverter._pos_to_iso(mouse_pos)
	var iso_loc = IsometricConverter.vector_shift(iso_mouse)
	if GameGlobal.camera_angle == 1:
		iso_loc = Vector2i(iso_mouse.y, -iso_mouse.x)
	elif GameGlobal.camera_angle == 3:
		iso_loc = Vector2i(-iso_mouse.y, iso_mouse.x)
	if GameGlobal.render_layers.has(iso_loc):
		var top = GameGlobal.render_layers[iso_loc].top()-1
		#if GameGlobal.player.current_colission_layer-3 > top:
			#show()
			#position = IsometricConverter._iso_to_pos(iso_mouse)
			#position.y -= (GameGlobal.player.current_colission_layer-3)*IsometricConverter.ISO_HEIGHT/2 + 1
		#else:
			#hide()
