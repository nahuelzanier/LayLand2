extends Node2D

func _process(delta):
		var mouse_pos = get_global_mouse_position() + Vector2(0, (GameGlobal.player.current_colission_layer-2)*IsometricConverter.ISO_HEIGHT/2)
		var iso_mouse = IsometricConverter._pos_to_iso(mouse_pos)
		if GameGlobal.render_layers.has(iso_mouse):
			var iso_loc = iso_mouse
			if GameGlobal.camera_angle == 1 || GameGlobal.camera_angle == 3:
				iso_loc = Vector2i(-iso_mouse.x, -iso_mouse.y)
			var top = GameGlobal.render_layers[IsometricConverter.vector_shift(iso_loc)].top()-1
			if GameGlobal.player.current_colission_layer-3 > top:
				show()
				position = IsometricConverter._iso_to_pos(iso_mouse)
				position.y -= (GameGlobal.player.current_colission_layer-3)*IsometricConverter.ISO_HEIGHT/2 + 1
			else:
				hide()
