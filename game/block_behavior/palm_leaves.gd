extends "res://game/block_behavior/_abstract_block_behavior.gd"

func _ready():
	tag = Tag.palm_leaves
	block_preload = GameGlobal.preload_scenes.BLOCK_PALM_LEAVES
	GameGlobal.block_behavior[Tag.palm_leaves] = self
	on_adjacent_func = "born_palm_leaves"

##UNLIFT
func unlift_empty(iso_loc):
	GameGlobal.player.block_held.pop_block()
	GameGlobal.player.block_held.pick_block(tag)
	GameGlobal.map_manager.set_tile(iso_loc, Tag.empty)
	GameGlobal.rerender_block(iso_loc)
	GameGlobal.born_queue.push_back(iso_loc)

func unlift_default(iso_loc):
	GameGlobal.block_behavior[GameGlobal.map_manager.get_tile(iso_loc+Vector3i(0,0,1))].call("unlift_default", iso_loc+Vector3i(0,0,1))
	GameGlobal.born_queue.push_back(iso_loc)

func unlift_wood_piece(iso_loc):
	GameGlobal.block_behavior[GameGlobal.map_manager.get_tile(iso_loc+Vector3i(0,0,1))].call("unlift_wood_piece", iso_loc+Vector3i(0,0,1))
	GameGlobal.born_queue.push_back(iso_loc)
	
func unlift_palm_leaves(iso_loc):
	GameGlobal.block_behavior[GameGlobal.map_manager.get_tile(iso_loc+Vector3i(0,0,1))].call("unlift_palm_leaves", iso_loc+Vector3i(0,0,1))
	GameGlobal.born_queue.push_back(iso_loc)

#BORN
#func born_empty(born_iso_pos, target_iso_pos):
	#if born_iso_pos.z < target_iso_pos.z:
		#GameGlobal.map_manager.switch_tiles(born_iso_pos, target_iso_pos)
		#GameGlobal.rerender_block(born_iso_pos)
		#GameGlobal.rerender_block(target_iso_pos)
		#GameGlobal.born_queue.push_back(born_iso_pos)
		#GameGlobal.born_queue.push_back(target_iso_pos)
