#SINGLETON

extends Node

var ISO_WIDTH = 32
var ISO_HEIGHT = 16
var THICKNESS = 16

func _iso_to_pos(vector2):
	return Vector2(vector2.x*ISO_WIDTH/2 - vector2.y*ISO_WIDTH/2, 
				   vector2.x*ISO_HEIGHT/2 + vector2.y*ISO_HEIGHT/2)

func _pos_to_iso(vector2):
	return Vector2i( floor(vector2.x/ISO_WIDTH + vector2.y/ISO_HEIGHT),
					floor(vector2.y/ISO_HEIGHT - vector2.x/ISO_WIDTH) )

func _pos_to_iso_float(vector2):
	return Vector2( vector2.x/ISO_WIDTH + vector2.y/ISO_HEIGHT,
					vector2.y/ISO_HEIGHT - vector2.x/ISO_WIDTH)

func vector_shift(vector2i):
	if GameGlobal.camera_angle == 0:
		return Vector2i(vector2i.x, vector2i.y)
	elif GameGlobal.camera_angle == 1:
		return Vector2i(-vector2i.y, vector2i.x)
	elif GameGlobal.camera_angle == 2:
		return Vector2i(-vector2i.x, -vector2i.y)
	elif GameGlobal.camera_angle == 3:
		return Vector2i(vector2i.y, -vector2i.x)

func vector_shift_rev(vector2i):
	if GameGlobal.camera_angle == 0:
		return Vector2i(vector2i.x, vector2i.y)
	elif GameGlobal.camera_angle == 1:
		return Vector2i(vector2i.y, -vector2i.x)
	elif GameGlobal.camera_angle == 2:
		return Vector2i(-vector2i.x, -vector2i.y)
	elif GameGlobal.camera_angle == 3:
		return Vector2i(-vector2i.y, vector2i.x)

func cursor_shift(vector2i):
	var iso_loc = vector2i
	if GameGlobal.camera_angle == 1 || GameGlobal.camera_angle == 3:
		iso_loc = Vector2i(-vector2i.x, -vector2i.y)
	return iso_loc

func spawn_shift(v3):
	if GameGlobal.camera_angle == 0:
		return Vector3i(v3.x, v3.y, v3.z)
	elif GameGlobal.camera_angle == 1:
		return Vector3i(-v3.y, v3.x, v3.z)
	elif GameGlobal.camera_angle == 2:
		return Vector3i(-v3.x, -v3.y, v3.z)
	elif GameGlobal.camera_angle == 3:
		return Vector3i(v3.y, -v3.x, v3.z)

func cursor_shift_v3(vector3i):
	var iso_loc = vector3i
	if GameGlobal.camera_angle == 1 || GameGlobal.camera_angle == 3:
		iso_loc = Vector3i(-vector3i.x, -vector3i.y, vector3i.z)
	return iso_loc
