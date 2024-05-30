extends Node

var main

var preload_scenes
var PRELOAD

var player
var cursor_scroll = 0

var world_timer

#TOTAL SIZE OF THE MAP ARRAY
var map_width = 50
var max_z_value = 18
#RENDERIZATION LIMIT
var map_max = 16
var map_min = -15
#SIZE RANGES
var x_range = range(map_min, map_max)
var y_range = range(map_min, map_max)
var z_range = range(0, max_z_value)

#CAMERA
var camera
var camera_angle = 0
var camera_manager

var block_behavior = {}
var born_queue = []

var map
var map_manager
var render
var render_layers = {}
var player_render

#LIFECYCLE (toSEEDLING, toTREE, toFRUIT, toFRUIT_MATURE, toFRUIT_FALL, TICKStoFRUIT_ROT) hours to
var fruit_coconut = [1, 1, 1, 1, 1, 2]

func in_map(v3):
	return render_layers.has(Vector2i(v3.x, v3.y))

func render_block(v3):
	if in_map(v3):
		var b_tag = map_manager.get_tile(v3)
		if b_tag == Tag.empty:
			render_layers[Vector2i(v3.x, v3.y)].column[v3.z].delete_block()
		elif preload_scenes.PRELOAD.has(b_tag):
		#if adjacent_to_empty(v3):
			var block = create_tile(map_manager.get_tile(v3))
			block.set_collisions(v3.z)
			render_layers[Vector2i(v3.x, v3.y)].column[v3.z].add_block(block)

func create_tile(block_tag):
	var block = preload_scenes.PRELOAD[block_tag].instantiate()
	return block

func erase_tile(v3):
	if in_map(v3):
		render_layers[Vector2i(v3.x,v3.y)].column[v3.z].delete_block()

func rerender_block(v3):
	erase_tile(v3)
	render_block(v3)

#func adjacent_to_empty(iso_pos):
	#var adjacents = [iso_pos+Vector3i(1,0,0), iso_pos+Vector3i(-1,0,0),
					#iso_pos+Vector3i(0,1,0), iso_pos+Vector3i(0,-1,0),
					#iso_pos+Vector3i(0,0,1), iso_pos+Vector3i(0,0,-1)]
	#var ren = false
	#for v in adjacents:
		#if v.x < GameGlobal.map_width && v.x > -GameGlobal.map_width && v.y < GameGlobal.map_width && v.y > -GameGlobal.map_width:
			#ren = ren or map_manager.get_tile(v)==Tag.empty
	#return ren
