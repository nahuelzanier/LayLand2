extends "res://game/block_behavior/_abstract_block_behavior.gd"

var tag = Tag.no_access

func _ready():
	GameGlobal.block_behavior[Tag.no_access] = self
	on_adjacent_func = "born_no_access"

func call_on_adjacents(iso_pos):pass

func born_default(born_iso_pos, target_iso_pos):
	print(born_iso_pos)
