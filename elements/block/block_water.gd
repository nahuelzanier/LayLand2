extends "res://elements/block/_block_abstract.gd"

var is_empty = false

func _ready():
	tag = "water"
	var white = Color(1, 1, 1, 1)
	var dark = ((8-float(collision)) / 8.0) / 1.1
	$AnimatedSprite2D.self_modulate = white.darkened(dark)

#UNLIFT
func unlift_default():
	var iso_pos_ang = Vector2i(iso_pos.x, iso_pos.y)
	if GameGlobal.render_layers[iso_pos_ang].top() < 16:
		GameGlobal.render_layers[iso_pos_ang].add_top(GameGlobal.PRELOAD[GameGlobal.player.block_held.block_held.tag])
		GameGlobal.player.block_held.replace_player_block(GameGlobal.preload_scenes.BLOCK_EMPTY)

##SPECIFIC TO WATER
func _on_water_flow_timeout():
	var iso_pos_v3 = iso_pos
	if not GameGlobal.render_layers[Vector2i(iso_pos_v3.x, iso_pos_v3.y)].column[iso_pos_v3.z-1].has_block:
		GameGlobal.move_tile(GameGlobal.PRELOAD[tag],iso_pos_v3, Vector3i(iso_pos_v3.x, iso_pos_v3.y, iso_pos_v3.z-1))
	elif trapped_water():
		$WaterFlow.stop()
	else:
		var iso_pos_v2 = Vector2i(iso_pos_v3.x, iso_pos_v3.y)
		var adjacent_tiles = [iso_pos_v2 + Vector2i(1,0), iso_pos_v2 + Vector2i(-1,0), iso_pos_v2 + Vector2i(0,1), iso_pos_v2 + Vector2i(0,-1)]
		var v = adjacent_tiles.pick_random()
		if GameGlobal.render_layers.has(v):
			if not GameGlobal.render_layers[v].column[iso_pos.z].has_block:
				GameGlobal.move_tile(GameGlobal.preload_scenes.BLOCK_WATER, iso_pos_v3, Vector3i(v.x, v.y, iso_pos_v3.z))
				if GameGlobal.render_layers[iso_pos_v2].column[iso_pos_v3.z+1].has_block:
					GameGlobal.render_layers[iso_pos_v2].column[iso_pos_v3.z+1].block.drop()

func trapped_water():
	var iso_pos_v3 = iso_pos
	var iso_pos_v2 = Vector2i(iso_pos_v3.x, iso_pos_v3.y)
	var adjacent_tiles = [iso_pos_v2 + Vector2i(1,0), iso_pos_v2 + Vector2i(-1,0), iso_pos_v2 + Vector2i(0,1), iso_pos_v2 + Vector2i(0,-1)]
	var ret = true
	for v in adjacent_tiles:
		ret = ret && GameGlobal.render_layers.has(v) && GameGlobal.render_layers[v].column[iso_pos_v3.z].has_block
	ret = ret && GameGlobal.render_layers[Vector2i(iso_pos_v3.x, iso_pos_v3.y)].column[iso_pos_v3.z-1].has_block
	return ret

func drop(): pass

func set_collisions(layer): pass

func disable_collisions(): pass

#ON_BORN
func born_empty(born_iso_pos):
	$WaterFlow.start()
