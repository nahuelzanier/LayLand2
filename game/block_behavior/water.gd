extends "res://game/block_behavior/_abstract_block_behavior.gd"

func _ready():
	tag = Tag.water
	block_preload = GameGlobal.preload_scenes.BLOCK_WATER
	GameGlobal.block_behavior[Tag.water] = self
	born_function = "born_water"

#BORN
func born_empty(born_iso_pos, target_iso_pos):
	if born_iso_pos.z == target_iso_pos.z || born_iso_pos.z < target_iso_pos.z:
		switch_tiles(born_iso_pos, target_iso_pos)
