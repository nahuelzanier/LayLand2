extends Node

var main
var preload_scenes
var PRELOAD

var player_render

var world_timer
var clock_tick = 0.5

var player

var displacement = Vector2i(0, 0)
var map_max = 16
var map_min = -15
var max_z_value = 17
var x_range = range(map_min, map_max)
var y_range = range(map_min, map_max)
var x_range_base = range(map_min, map_max)
var y_range_base = range(map_min, map_max)
var camera_angle = 0

var map
var render_layers = {}

#LIFECYCLE (toSEEDLING, toTREE, toFRUIT, toFRUIT_MATURE, toFRUIT_FALL, TICKStoFRUIT_ROT) hours to
var fruit_coconut = [1, 1, 1, 1, 1, 2]

func player_pos_reset():
	var x = x_range[map_max]
	var y = y_range[map_max]
	return IsometricConverter._iso_to_pos(IsometricConverter.vector_shift(Vector2i(x, y)))

func render_block(v3):
	var block = create_tile(map[v3], v3)
	render_layers[Vector2i(v3.x, v3.y)].column[v3.z].add_block(block)
	render_layers[Vector2i(v3.x, v3.y)].column[v3.z].block.on_creation()

func create_tile(block_tag, vector3i):
	var block = preload_scenes.PRELOAD[block_tag].instantiate()
	block.set_collisions(vector3i.z)
	return block

#func create_tile(block_preload, vector3i):
	#var block = block_preload.instantiate()
	#block.collision = vector3i.z
	#block.set_collisions(vector3i.z)
	#render_block(block, vector3i)

func erase_tile(vector3i):
	render_layers[Vector2i(vector3i.x,vector3i.y)].column[vector3i.z].delete_block()
	var adjacents = [vector3i+Vector3i(1,0,0), vector3i+Vector3i(-1,0,0),
				vector3i+Vector3i(0,1,0), vector3i+Vector3i(0,-1,0)]
	var top = vector3i+Vector3i(0,0,1)
	var bottom = vector3i+Vector3i(0,0,-1)
	for v in adjacents:
		if render_layers.has(Vector2i(v.x, v.y)):
			if render_layers[Vector2i(v.x, v.y)].column[v.z].has_block:
				render_layers[Vector2i(v.x, v.y)].column[v.z].block.born_empty(Vector3(v.x, v.y, vector3i.z))
	if render_layers[Vector2i(vector3i.x, vector3i.y)].column[top.z].has_block:
		render_layers[Vector2i(vector3i.x, vector3i.y)].column[top.z].block.born_empty(Vector3(top.x, top.y, top.z))
	if render_layers[Vector2i(vector3i.x, vector3i.y)].column[bottom.z].has_block:
		render_layers[Vector2i(vector3i.x, vector3i.y)].column[bottom.z].block.born_empty(Vector3(bottom.x, bottom.y, bottom.z))

func replace_tile(block_preload, vector3i):
	erase_tile(vector3i)
	create_tile(block_preload, vector3i)

func move_tile(block_preload, fromv3i, tov3i):
	erase_tile(fromv3i)
	create_tile(block_preload, tov3i)
	
func move_replace(block_preload, fromv3i, tov3i):
	erase_tile(fromv3i)
	if render_layers[Vector2i(tov3i.x,tov3i.y)].column[tov3i.z].has_block:
		erase_tile(tov3i)
	create_tile(PRELOAD["empty"], fromv3i)
	create_tile(block_preload, tov3i)
