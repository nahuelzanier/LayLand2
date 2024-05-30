extends Node2D

var index
var block

func add_block(block_par):
	block = block_par
	add_child(block)

func delete_block():
	if not block == null:
		block.queue_free()
