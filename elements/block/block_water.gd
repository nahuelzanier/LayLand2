extends "res://elements/block/_block_abstract.gd"

var is_empty = false

func _ready():
	tag = "water"
	color_gradient()
	$WaterFlow.wait_time = GameGlobal.clock_tick

func on_creation():
	get_iso_pos()
	$WaterFlow.start()

#UNLIFT
func unlift_default():
	get_iso_pos()
	var iso_pos_ang = Vector2i(iso_pos.x, iso_pos.y)
	if GameGlobal.render_layers[iso_pos_ang].top() < 16:
		GameGlobal.render_layers[iso_pos_ang].add_top(GameGlobal.PRELOAD[GameGlobal.player.block_held.block_held.tag])
		GameGlobal.player.block_held.replace_player_block(GameGlobal.preload_scenes.BLOCK_EMPTY)

func drop(): pass

func set_collisions(layer):
	collision = layer + 1

func disable_collisions(): pass


##SPECIFIC TO WATER
func _on_water_flow_timeout():
	water_flow()

func water_flow():
	get_iso_pos()
	if not GameGlobal.render_layers[Vector2i(iso_pos.x, iso_pos.y)].column[iso_pos.z-1].has_block:
		GameGlobal.move_tile(GameGlobal.PRELOAD[tag],iso_pos, Vector3i(iso_pos.x, iso_pos.y, iso_pos.z-1))
	elif trapped_water():
		$WaterFlow.stop()
	else:
		var iso_pos_v2 = Vector2i(iso_pos.x, iso_pos.y)
		var adjacent_tiles = [Vector2i(1,0), Vector2i(-1,0), Vector2i(0,1), Vector2i(0,-1)]
		adjacent_tiles.shuffle()
		for v in adjacent_tiles:
			if GameGlobal.render_layers.has(iso_pos_v2 + v):
				if not GameGlobal.render_layers[iso_pos_v2 + v].column[iso_pos.z].has_block:
					if randi()%20==0:
						GameGlobal.create_tile(GameGlobal.preload_scenes.BLOCK_WATER, iso_pos + Vector3i(v.x, v.y, 0))
					else:
						move_water(iso_pos, iso_pos + Vector3i(v.x, v.y, 0))
						break

func trapped_water():
	get_iso_pos()
	var iso_pos_v3 = iso_pos
	var iso_pos_v2 = Vector2i(iso_pos_v3.x, iso_pos_v3.y)
	var adjacent_tiles = [iso_pos_v2 + Vector2i(1,0), iso_pos_v2 + Vector2i(-1,0), iso_pos_v2 + Vector2i(0,1), iso_pos_v2 + Vector2i(0,-1)]
	var ret = true
	for v in adjacent_tiles:
		ret = ret && GameGlobal.render_layers.has(v) && GameGlobal.render_layers[v].column[iso_pos_v3.z].has_block
	ret = ret && GameGlobal.render_layers[Vector2i(iso_pos_v3.x, iso_pos_v3.y)].column[iso_pos_v3.z-1].has_block
	return ret

func move_water(from_iso, to_iso_pos):
	get_iso_pos()
	if GameGlobal.render_layers.has(Vector2i(to_iso_pos.x, to_iso_pos.y)):
		if not GameGlobal.render_layers[Vector2i(to_iso_pos.x, to_iso_pos.y)].column[iso_pos.z].has_block:
			GameGlobal.move_tile(GameGlobal.preload_scenes.BLOCK_WATER, from_iso, to_iso_pos)

#ON_BORN
func born_empty(born_iso_pos):
	$WaterFlow.wait_time = GameGlobal.clock_tick
	$WaterFlow.start()
