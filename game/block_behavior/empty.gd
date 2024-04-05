extends "res://game/block_behavior/_abstract_block_behavior.gd"

var tag = Tag.empty

func _ready():
	GameGlobal.block_behavior[Tag.empty] = self
	on_adjacent_func = "born_empty"

#BORN
func born_default(born_iso_pos, target_iso_pos):
	if born_iso_pos.z > target_iso_pos.z:
		GameGlobal.map_manager.switch_tiles(born_iso_pos, target_iso_pos)
		GameGlobal.rerender_block(born_iso_pos)
		GameGlobal.rerender_block(target_iso_pos)
		GameGlobal.born_queue.push_back(born_iso_pos)
		GameGlobal.born_queue.push_back(target_iso_pos)
