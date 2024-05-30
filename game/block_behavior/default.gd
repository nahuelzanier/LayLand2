extends "res://game/block_behavior/_abstract_block_behavior.gd"

func _ready():
	tag = Tag.default
	block_preload = GameGlobal.preload_scenes.BLOCK_DEFAULT
	GameGlobal.block_behavior[Tag.default] = self
	born_function = "born_default"

#BORN
func born_empty(born_iso_pos, target_iso_pos):
	if born_iso_pos.z < target_iso_pos.z:
		switch_tiles(born_iso_pos, target_iso_pos)
