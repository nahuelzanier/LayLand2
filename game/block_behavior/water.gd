extends "res://game/block_behavior/_abstract_block_behavior.gd"

var tag = Tag.no_access

func _ready():
	GameGlobal.block_behavior[Tag.water] = self
	on_adjacent_func = "born_water"

func call_on_adjacents(iso_pos):pass
