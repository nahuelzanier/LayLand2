extends "res://game/block_behavior/_abstract_block_behavior.gd"

func _ready():
	tag = Tag.no_access
	GameGlobal.block_behavior[Tag.no_access] = self

func call_on_adjacents(iso_pos, function):pass
