extends Node2D

@onready var camera_2d = $Camera2D
var prev_camera_pos

func _ready():
	GameGlobal.camera = self
	prev_camera_pos = Vector2i(0,0)

func _process(delta):
	var scroll = Vector2(0,0)
	var mouse = global_position - get_global_mouse_position()
	
	if mouse.x > 0.46*get_viewport_rect().size.x:
		scroll.x = -1

	if mouse.x < -0.46*get_viewport_rect().size.x:
		scroll.x = 1

	if mouse.y > 0.46*get_viewport_rect().size.y:
		scroll.y = -1

	if mouse.y < -0.46*get_viewport_rect().size.y:
		scroll.y = 1

	position += 8*scroll
	var iso_camera = IsometricConverter.cursor_shift(IsometricConverter.vector_shift(iso_map()))
	if iso_camera != prev_camera_pos:
		GameGlobal.camera_manager.update_map(iso_camera - prev_camera_pos)
		prev_camera_pos = iso_camera

func iso_map():
	return Vector2i(
		max(min(iso_pos().x, GameGlobal.map_width), -GameGlobal.map_width),
		max(min(iso_pos().y, GameGlobal.map_width), -GameGlobal.map_width)
	)

func iso_pos():
	return IsometricConverter._pos_to_iso(global_position)
