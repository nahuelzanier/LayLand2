extends Node2D

@onready var block_orderer = $BlockOrderer

var block_held

func _ready():
	var empty_block = GameGlobal.preload_scenes.BLOCK_EMPTY.instantiate()
	block_held = empty_block
	block_orderer.add_child(block_held)

func is_empty():
	return block_held.is_empty

func pop_block():
	block_held.queue_free()

func pick_block(block_tag):
	block_held = GameGlobal.preload_scenes.PRELOAD[block_tag].instantiate()
	block_held.collision = 10
	block_orderer.add_child(block_held)

func replace_player_block(block_preload):
	pop_block()
	var block = block_preload.instantiate()
	pick_block(block)
