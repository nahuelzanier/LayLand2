extends "res://elements/block/_block_abstract.gd"

var is_empty = false

func _ready():
	tag = Tag.default
	color_gradient()
	unlift_function = "unlift_default"
#	$DropTimer.wait_time = GameGlobal.clock_tick

##UNLIFT
#func unlift_empty(iso_loc):
	#var vec = Vector3i(iso_loc.x, iso_loc.y, GameGlobal.render_layers[iso_loc].top() - 2 + GameGlobal.cursor_scroll)
	#var block = GameGlobal.map_manager.get_tile(vec)
	#GameGlobal.player.block_held.pop_block()
	#GameGlobal.player.block_held.pick_block(GameGlobal.preload_scenes.PRELOAD[block].instantiate())
	#GameGlobal.map_manager.set_tile(vec, Tag.empty)
	#GameGlobal.rerender_block(vec)
	#GameGlobal.born_queue.push_back(vec)
#
#func unlift_default():
	#get_iso_pos()
	#var iso_pos_ang = Vector2i(iso_pos.x, iso_pos.y)
	#if GameGlobal.render_layers[iso_pos_ang].top() < 16:
		#GameGlobal.render_layers[iso_pos_ang].add_top(GameGlobal.player.block_held.block_held.tag)
		#GameGlobal.player.block_held.replace_player_block(GameGlobal.preload_scenes.BLOCK_EMPTY)
#
#func _on_drop_timer_timeout():
	#get_iso_pos()
	#if not GameGlobal.render_layers[Vector2i(iso_pos.x, iso_pos.y)].column[iso_pos.z-1].has_block:
		#GameGlobal.move_tile(GameGlobal.PRELOAD[tag],iso_pos, Vector3i(iso_pos.x, iso_pos.y, iso_pos.z-1))
#
#func born_empty(born_iso_pos):
	#if born_iso_pos.z < iso_pos.z:
		#GameGlobal.switch_tiles(born_iso_pos, iso_pos)
