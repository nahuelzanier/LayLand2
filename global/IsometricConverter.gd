#SINGLETON

extends Node

var ISO_WIDTH = 32
var ISO_HEIGHT = 16

func _iso_to_pos(vector2):
	return Vector2i(vector2.x*ISO_WIDTH/2 - vector2.y*ISO_WIDTH/2, 
				   vector2.x*ISO_HEIGHT/2 + vector2.y*ISO_HEIGHT/2)

func _pos_to_iso(vector2):
	return Vector2i( floor(vector2.x/ISO_WIDTH + vector2.y/ISO_HEIGHT),
					floor(vector2.y/ISO_HEIGHT - vector2.x/ISO_WIDTH) )

func vector_shift(vector2i):
	if GameGlobal.camera_angle == 0:
		return Vector2i(vector2i.x, vector2i.y)
	elif GameGlobal.camera_angle == 1:
		return Vector2i(-vector2i.y, vector2i.x)
	elif GameGlobal.camera_angle == 2:
		return Vector2i(-vector2i.x, -vector2i.y)
	elif GameGlobal.camera_angle == 3:
		return Vector2i(vector2i.y, -vector2i.x)
#
func cursor_shift(vector2i):
	var iso_loc = vector2i
	if GameGlobal.camera_angle == 1 || GameGlobal.camera_angle == 3:
		iso_loc = Vector2i(-vector2i.x, -vector2i.y)
	return iso_loc

#func map_shift(vector2i):
	#if GameGlobal.camera_angle == 0:
		#return Vector2i(vector2i.x, vector2i.y)
	#elif GameGlobal.camera_angle == 1:
		#return Vector2i(-vector2i.y, vector2i.x)
	#elif GameGlobal.camera_angle == 2:
		#return Vector2i(-vector2i.x, -vector2i.y)
	#elif GameGlobal.camera_angle == 3:
		#return Vector2i(vector2i.y, -vector2i.x)
