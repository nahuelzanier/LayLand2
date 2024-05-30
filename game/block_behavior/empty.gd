extends "res://game/block_behavior/_abstract_block_behavior.gd"

func _ready():
	tag = Tag.empty
	block_preload = GameGlobal.preload_scenes.BLOCK_EMPTY
	GameGlobal.block_behavior[Tag.empty] = self
	born_function = "born_empty"

#BORN
func born_default(born_iso_pos, target_iso_pos):
	if born_iso_pos.z > target_iso_pos.z:
		switch_tiles(born_iso_pos, target_iso_pos)

func born_water(born_iso_pos, target_iso_pos):
	if born_iso_pos.z == target_iso_pos.z || born_iso_pos.z > target_iso_pos.z:
		switch_tiles(born_iso_pos, target_iso_pos)

