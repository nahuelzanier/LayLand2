extends "res://game/block_behavior/_abstract_block_behavior.gd"

func _ready():
	tag = Tag.sand
	block_preload = GameGlobal.preload_scenes.BLOCK_SAND
	GameGlobal.block_behavior[Tag.sand] = self
	on_adjacent_func = "born_sand"
