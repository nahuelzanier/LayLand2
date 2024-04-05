extends "res://game/block_behavior/_abstract_block_behavior.gd"

var tag = Tag.default

func _ready():
	GameGlobal.block_behavior[Tag.default] = self
	on_adjacent_func = "born_default"

##UNLIFT
func unlift_empty(iso_loc):
	GameGlobal.player.block_held.pop_block()
	GameGlobal.player.block_held.pick_block(tag)
	GameGlobal.map_manager.set_tile(iso_loc, Tag.empty)
	GameGlobal.rerender_block(iso_loc)
	#GameGlobal.born_queue.push_back(iso_loc)

#BORN
func born_empty(born_iso_pos, target_iso_pos):
	if born_iso_pos.z < target_iso_pos.z:
		GameGlobal.map_manager.switch_tiles(born_iso_pos, target_iso_pos)
		GameGlobal.rerender_block(born_iso_pos)
		GameGlobal.rerender_block(target_iso_pos)
		GameGlobal.born_queue.push_back(born_iso_pos)
		GameGlobal.born_queue.push_back(target_iso_pos)
