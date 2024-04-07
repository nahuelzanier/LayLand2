extends "res://game/block_behavior/_abstract_block_behavior.gd"

var tag = Tag.no_access

func _ready():
	GameGlobal.block_behavior[Tag.water] = self
	on_adjacent_func = "born_water"

#BORN
func born_empty(born_iso_pos, target_iso_pos):
	if born_iso_pos.z == target_iso_pos.z || born_iso_pos.z < target_iso_pos.z:
		GameGlobal.map_manager.set_tile(born_iso_pos, Tag.water)
		GameGlobal.rerender_block(born_iso_pos)
		GameGlobal.born_queue.push_back(born_iso_pos)
